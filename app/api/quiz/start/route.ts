import { NextResponse } from "next/server";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";
import {
  allowedDifficulties,
  isTopicAllowed,
  type LevelTier,
  type QuestionTopic,
} from "@/lib/leveling";

export const runtime = "nodejs";

const Body = z.object({
  topic: z.enum(["main_idea", "blank", "vocabulary", "grammar"]),
});

// POST /api/quiz/start  (form-urlencoded or JSON)
// 두 가지 모드
//  1) topic 모드      : 카테고리별 10문제 (여러 지문 섞임)
//  2) passageId 모드  : 방금 깊이 읽은 그 지문의 문제만 (주제·빈칸·어휘 섞임)
export async function POST(req: Request) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) {
    return NextResponse.redirect(new URL("/login", req.url));
  }
  const userId = userResp.user.id;

  // Parse from form or JSON
  const contentType = req.headers.get("content-type") ?? "";
  let rawTopic: string | null = null;
  let passageId: string | null = null;
  if (contentType.includes("application/json")) {
    const json = await req.json();
    rawTopic = json.topic ? String(json.topic) : null;
    passageId = json.passageId ? String(json.passageId) : null;
  } else {
    const form = await req.formData();
    rawTopic = form.get("topic") ? String(form.get("topic")) : null;
    passageId = form.get("passageId") ? String(form.get("passageId")) : null;
  }

  if (passageId) {
    return startPassageSession(supabase, req, userId, passageId);
  }

  const topic = Body.parse({ topic: rawTopic }).topic;

  // Load caller profile for level-based filtering
  const { data: profile } = await supabase
    .from("te_profiles")
    .select("level_tier")
    .eq("id", userId)
    .maybeSingle();
  const level = (profile?.level_tier ?? null) as LevelTier | null;
  const topicTyped = topic as QuestionTopic;

  // Hard gate: refuse to start if topic isn't allowed at this level
  if (!isTopicAllowed(level, topicTyped)) {
    return NextResponse.redirect(new URL("/learn/quiz?err=topic_locked", req.url), 303);
  }

  const allowedDiff = allowedDifficulties(level);

  // Find IDs of recently used questions to avoid repetition in next session
  const { data: pastAttempts } = await supabase
    .from("te_question_attempts")
    .select("question_id")
    .eq("user_id", userId)
    .order("answered_at", { ascending: false })
    .limit(50);
  const recentIds = new Set((pastAttempts ?? []).map((a) => a.question_id));

  // Pull candidate questions for the topic, filtered by allowed difficulty
  const { data: candidates } = await supabase
    .from("te_questions")
    .select("id, difficulty")
    .eq("topic", topic)
    .in("difficulty", allowedDiff);

  if (!candidates || candidates.length === 0) {
    return NextResponse.redirect(new URL("/learn/quiz?err=no_questions", req.url), 303);
  }

  // Prefer un-attempted; if not enough, fall back to all.
  const fresh = candidates.filter((q) => !recentIds.has(q.id));
  const pool = fresh.length >= 1 ? fresh : candidates;
  const shuffled = pool.sort(() => Math.random() - 0.5);
  const batchSize = Math.min(10, shuffled.length);
  const picked = shuffled.slice(0, batchSize);

  return createSession(supabase, req, userId, topic, picked.map((q) => q.id));
}

/**
 * 지문 묶음 모드 — 학생이 방금 1~5단계로 읽은 그 지문의 문제만 낸다.
 * 새 지문 10개를 들이밀지 않는 게 핵심. 난이도·카테고리 잠금은 적용하지 않는다
 * (이미 그 지문을 통째로 읽은 뒤이므로).
 */
async function startPassageSession(
  supabase: ReturnType<typeof createClient>,
  req: Request,
  userId: string,
  passageId: string,
) {
  const { data: questions } = await supabase
    .from("te_questions")
    .select("id, topic")
    .eq("passage_id", passageId);

  if (!questions || questions.length === 0) {
    return NextResponse.redirect(
      new URL(`/learn/passages/${passageId}/quiz?err=no_questions`, req.url),
      303,
    );
  }

  // 이미 이 지문으로 시작해 둔 미완료 세션이 있으면 그걸 이어서
  const questionIds = new Set(questions.map((q) => q.id));
  const { data: openSessions } = await supabase
    .from("te_quiz_sessions")
    .select("id")
    .eq("user_id", userId)
    .is("completed_at", null)
    .order("started_at", { ascending: false })
    .limit(10);

  if (openSessions && openSessions.length > 0) {
    const { data: openAttempts } = await supabase
      .from("te_question_attempts")
      .select("session_id, question_id")
      .in(
        "session_id",
        openSessions.map((s) => s.id),
      );
    const bySession = new Map<string, string[]>();
    for (const a of openAttempts ?? []) {
      const arr = bySession.get(a.session_id) ?? [];
      arr.push(a.question_id);
      bySession.set(a.session_id, arr);
    }
    for (const s of openSessions) {
      const qs = bySession.get(s.id) ?? [];
      if (qs.length > 0 && qs.every((qid) => questionIds.has(qid))) {
        return NextResponse.redirect(new URL(`/learn/quiz/${s.id}/play`, req.url), 303);
      }
    }
  }

  // 주제 → 빈칸 → 어휘 순으로 정렬 (쉬운 것부터)
  const order: Record<string, number> = { main_idea: 0, blank: 1, vocabulary: 2, grammar: 3 };
  const picked = [...questions]
    .sort((a, b) => (order[a.topic] ?? 9) - (order[b.topic] ?? 9))
    .slice(0, 10);

  // 세션 topic 컬럼은 enum이라 대표 토픽 하나를 넣는다 (표시는 지문 제목으로)
  const counts = new Map<string, number>();
  for (const q of picked) counts.set(q.topic, (counts.get(q.topic) ?? 0) + 1);
  const dominant =
    [...counts.entries()].sort((a, b) => b[1] - a[1])[0]?.[0] ?? "main_idea";

  return createSession(
    supabase,
    req,
    userId,
    dominant,
    picked.map((q) => q.id),
  );
}

async function createSession(
  supabase: ReturnType<typeof createClient>,
  req: Request,
  userId: string,
  topic: string,
  questionIds: string[],
) {
  const { data: session, error: sessErr } = await supabase
    .from("te_quiz_sessions")
    .insert({
      user_id: userId,
      topic,
      batch_size: questionIds.length,
    })
    .select("id")
    .single();

  if (sessErr || !session) {
    return NextResponse.json({ error: sessErr?.message ?? "session_failed" }, { status: 500 });
  }

  const rows = questionIds.map((qid, i) => ({
    session_id: session.id,
    question_id: qid,
    user_id: userId,
    ord: i + 1,
  }));
  const { error: attErr } = await supabase.from("te_question_attempts").insert(rows);
  if (attErr) {
    return NextResponse.json({ error: attErr.message }, { status: 500 });
  }

  return NextResponse.redirect(new URL(`/learn/quiz/${session.id}/play`, req.url), 303);
}
