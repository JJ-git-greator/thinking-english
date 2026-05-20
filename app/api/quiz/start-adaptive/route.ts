import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import {
  allowedDifficulties,
  allowedTopics,
  type LevelTier,
  type QuestionTopic,
} from "@/lib/leveling";
import { computeStats, adaptiveDistribution } from "@/lib/weakness";

export const runtime = "nodejs";

/**
 * 적응형 퀴즈 세션 시작
 * 1. 학생 최근 50개 답안 → 카테고리별 정답률 분석
 * 2. 약점 카테고리 60%, 나머지 균등으로 10문제 분포 결정
 * 3. 그 분포대로 문제 추출 → 세션 시작
 */
export async function POST(req: Request) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) return NextResponse.redirect(new URL("/login", req.url));
  const userId = userResp.user.id;

  const { data: profile } = await supabase
    .from("te_profiles")
    .select("level_tier")
    .eq("id", userId)
    .maybeSingle();
  const level = (profile?.level_tier ?? null) as LevelTier | null;
  const topics = allowedTopics(level).filter(
    (t): t is Exclude<QuestionTopic, "grammar"> => t !== "grammar",
  ) as QuestionTopic[]; // grammar는 Phase 3 후반
  const diffs = allowedDifficulties(level);

  if (topics.length === 0) {
    return NextResponse.redirect(new URL("/learn/quiz?err=no_topics", req.url));
  }

  // 학생 최근 답안 50개 (카테고리·정오답)
  const { data: recentRaw } = await supabase
    .from("te_question_attempts")
    .select("is_correct, te_questions(topic)")
    .eq("user_id", userId)
    .not("is_correct", "is", null)
    .order("answered_at", { ascending: false })
    .limit(50);

  const recent = (recentRaw ?? []).map((a) => {
    const q = Array.isArray(a.te_questions) ? a.te_questions[0] : (a.te_questions as any);
    return {
      topic: q?.topic as QuestionTopic,
      is_correct: a.is_correct,
    };
  }).filter((a) => a.topic && topics.includes(a.topic));

  const stats = computeStats(recent);
  const plan = adaptiveDistribution(stats, topics, 10);

  // 분포에 따라 문제 추출
  const { data: pastAttemptsAll } = await supabase
    .from("te_question_attempts")
    .select("question_id")
    .eq("user_id", userId)
    .order("answered_at", { ascending: false })
    .limit(50);
  const recentIds = new Set((pastAttemptsAll ?? []).map((a) => a.question_id));

  const picked: { id: string; topic: QuestionTopic }[] = [];
  for (const t of topics) {
    const need = plan.distribution[t];
    if (need === 0) continue;

    const { data: candidates } = await supabase
      .from("te_questions")
      .select("id")
      .eq("topic", t)
      .in("difficulty", diffs);

    if (!candidates || candidates.length === 0) continue;

    const fresh = candidates.filter((c) => !recentIds.has(c.id));
    const pool = fresh.length >= need ? fresh : candidates;
    const shuffled = pool.sort(() => Math.random() - 0.5);
    for (const q of shuffled.slice(0, need)) {
      picked.push({ id: q.id, topic: t });
    }
  }

  if (picked.length === 0) {
    return NextResponse.redirect(new URL("/learn/quiz?err=no_questions", req.url));
  }

  // 분포가 모자라면 그냥 그만큼만. topic은 "main_idea"로 fallback (세션에는 대표 토픽 하나 필요)
  const sessionTopic: QuestionTopic = plan.weakestTopic ?? topics[0];

  const { data: session, error: sessErr } = await supabase
    .from("te_quiz_sessions")
    .insert({
      user_id: userId,
      topic: sessionTopic,
      batch_size: picked.length,
    })
    .select("id")
    .single();
  if (sessErr || !session) {
    return NextResponse.json({ error: sessErr?.message ?? "session_failed" }, { status: 500 });
  }

  // 셔플해서 attempt rows 생성
  const shuffled = picked.sort(() => Math.random() - 0.5);
  const rows = shuffled.map((q, i) => ({
    session_id: session.id,
    question_id: q.id,
    user_id: userId,
    ord: i + 1,
  }));
  const { error: attErr } = await supabase.from("te_question_attempts").insert(rows);
  if (attErr) {
    return NextResponse.json({ error: attErr.message }, { status: 500 });
  }

  return NextResponse.redirect(new URL(`/learn/quiz/${session.id}/play`, req.url));
}
