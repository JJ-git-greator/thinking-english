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
export async function POST(req: Request) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) {
    return NextResponse.redirect(new URL("/login", req.url));
  }
  const userId = userResp.user.id;

  // Parse from form or JSON
  const contentType = req.headers.get("content-type") ?? "";
  let topic: string;
  if (contentType.includes("application/json")) {
    const json = await req.json();
    topic = Body.parse(json).topic;
  } else {
    const form = await req.formData();
    topic = Body.parse({ topic: String(form.get("topic")) }).topic;
  }

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
    return NextResponse.redirect(new URL("/learn/quiz?err=topic_locked", req.url));
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
    return NextResponse.redirect(new URL("/learn/quiz?err=no_questions", req.url));
  }

  // Prefer un-attempted; if not enough, fall back to all.
  const fresh = candidates.filter((q) => !recentIds.has(q.id));
  const pool = fresh.length >= 1 ? fresh : candidates;
  const shuffled = pool.sort(() => Math.random() - 0.5);
  const batchSize = Math.min(10, shuffled.length);
  const picked = shuffled.slice(0, batchSize);

  // Create session
  const { data: session, error: sessErr } = await supabase
    .from("te_quiz_sessions")
    .insert({
      user_id: userId,
      topic,
      batch_size: batchSize,
    })
    .select("id")
    .single();

  if (sessErr || !session) {
    return NextResponse.json({ error: sessErr?.message ?? "session_failed" }, { status: 500 });
  }

  // Create empty attempts rows in order
  const rows = picked.map((q, i) => ({
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
