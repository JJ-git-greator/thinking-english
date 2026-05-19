import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

export const runtime = "nodejs";

// POST /api/quiz/[sid]/grade
// Compares chosen_answer vs correct_answer for each attempt in the session,
// fills is_correct, then sets session.completed_at and total_correct.
export async function POST(
  _req: Request,
  { params }: { params: { sid: string } },
) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) return NextResponse.json({ error: "unauthorized" }, { status: 401 });
  const userId = userResp.user.id;

  const sessionId = params.sid;

  const { data: session, error: sErr } = await supabase
    .from("te_quiz_sessions")
    .select("id, user_id, completed_at, batch_size")
    .eq("id", sessionId)
    .maybeSingle();

  if (sErr || !session) {
    return NextResponse.json({ error: "session_not_found" }, { status: 404 });
  }
  if (session.user_id !== userId) {
    return NextResponse.json({ error: "forbidden" }, { status: 403 });
  }
  if (session.completed_at) {
    return NextResponse.json({ ok: true, alreadyCompleted: true });
  }

  const { data: attempts, error: aErr } = await supabase
    .from("te_question_attempts")
    .select("id, chosen_answer, question_id, te_questions(correct_answer)")
    .eq("session_id", sessionId);

  if (aErr || !attempts) {
    return NextResponse.json({ error: aErr?.message ?? "load_failed" }, { status: 500 });
  }

  // Refuse to grade if any chosen_answer is missing
  if (attempts.some((a) => !a.chosen_answer)) {
    return NextResponse.json(
      { error: "incomplete", message: "아직 답하지 않은 문제가 있습니다." },
      { status: 400 },
    );
  }

  // Update is_correct per attempt
  let totalCorrect = 0;
  for (const a of attempts) {
    const correct = Array.isArray(a.te_questions)
      ? a.te_questions[0]?.correct_answer
      : (a.te_questions as any)?.correct_answer;
    const ok = a.chosen_answer === correct;
    if (ok) totalCorrect++;
    await supabase
      .from("te_question_attempts")
      .update({ is_correct: ok })
      .eq("id", a.id);
  }

  // Mark session completed
  await supabase
    .from("te_quiz_sessions")
    .update({
      completed_at: new Date().toISOString(),
      total_correct: totalCorrect,
      // remediation_done stays false until all wrongs have remediation_text
      remediation_done: totalCorrect === attempts.length,
    })
    .eq("id", sessionId);

  // Update progress aggregates (best-effort)
  await updateProgress(supabase, userId);

  return NextResponse.json({ ok: true, totalCorrect, total: attempts.length });
}

async function updateProgress(supabase: ReturnType<typeof createClient>, userId: string) {
  const { data: sessions } = await supabase
    .from("te_quiz_sessions")
    .select("id, total_correct, batch_size, completed_at")
    .eq("user_id", userId)
    .not("completed_at", "is", null);

  const totalSessions = sessions?.length ?? 0;
  const totalAnswered = (sessions ?? []).reduce((a, s) => a + (s.batch_size ?? 0), 0);
  const totalCorrect = (sessions ?? []).reduce((a, s) => a + (s.total_correct ?? 0), 0);

  await supabase
    .from("te_student_progress")
    .upsert({
      user_id: userId,
      total_quiz_sessions: totalSessions,
      total_questions_answered: totalAnswered,
      total_questions_correct: totalCorrect,
      last_active_at: new Date().toISOString(),
    });
}
