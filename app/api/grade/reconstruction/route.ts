import { NextResponse } from "next/server";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";
import { gradeReconstruction } from "@/lib/claude/grade-reconstruction";

export const runtime = "nodejs";

const Body = z.object({
  paragraphId: z.string().uuid(),
  studentText: z.string().min(10).max(4000),
  preferSmart: z.boolean().optional(),
});

export async function POST(req: Request) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) {
    return NextResponse.json({ error: "unauthorized" }, { status: 401 });
  }
  const userId = userResp.user.id;

  let parsed: z.infer<typeof Body>;
  try {
    parsed = Body.parse(await req.json());
  } catch (err) {
    return NextResponse.json({ error: "invalid_body" }, { status: 400 });
  }

  // Fetch paragraph (RLS will enforce access)
  const { data: paragraph, error: pErr } = await supabase
    .from("te_paragraphs")
    .select("id, body")
    .eq("id", parsed.paragraphId)
    .maybeSingle();

  if (pErr || !paragraph) {
    return NextResponse.json({ error: "paragraph_not_found" }, { status: 404 });
  }

  // Fetch user's Gist note for this paragraph
  const { data: gist } = await supabase
    .from("te_gist_notes")
    .select("id, main_idea_text, supporting_text")
    .eq("user_id", userId)
    .eq("paragraph_id", paragraph.id)
    .maybeSingle();

  if (!gist?.main_idea_text || !gist?.supporting_text) {
    return NextResponse.json(
      { error: "gist_required", message: "Gist 노트를 먼저 완료해 주세요." },
      { status: 400 },
    );
  }

  // Grade with Claude
  let result;
  try {
    result = await gradeReconstruction({
      paragraphBody: paragraph.body,
      mainIdea: gist.main_idea_text,
      supporting: gist.supporting_text,
      studentText: parsed.studentText,
      preferSmart: parsed.preferSmart,
    });
  } catch (err) {
    console.error("[grade]", err);
    return NextResponse.json(
      { error: "grading_failed", message: err instanceof Error ? err.message : "unknown" },
      { status: 500 },
    );
  }

  // Save attempt
  const { data: inserted, error: insErr } = await supabase
    .from("te_reconstruction_attempts")
    .insert({
      user_id: userId,
      paragraph_id: paragraph.id,
      gist_note_id: gist.id,
      student_text: parsed.studentText,
      ai_score: result.score,
      ai_subscores: result.subscores,
      ai_feedback: {
        strengths: result.strengths,
        weaknesses: result.weaknesses,
        suggestions: result.suggestions,
        rewritten_example: result.rewritten_example,
      },
      ai_model: result.model,
    })
    .select("id")
    .single();

  if (insErr) {
    return NextResponse.json(
      { error: "save_failed", message: insErr.message },
      { status: 500 },
    );
  }

  // Update progress (cheap upsert)
  await updateProgress(supabase, userId);

  return NextResponse.json({
    attemptId: inserted.id,
    ...result,
  });
}

async function updateProgress(supabase: ReturnType<typeof createClient>, userId: string) {
  const { data: aggGist } = await supabase
    .from("te_gist_notes")
    .select("paragraph_id", { count: "exact", head: false })
    .eq("user_id", userId);

  const { data: aggRecon } = await supabase
    .from("te_reconstruction_attempts")
    .select("ai_score")
    .eq("user_id", userId);

  const totalGist = aggGist?.length ?? 0;
  const totalRecon = aggRecon?.length ?? 0;
  const scores = (aggRecon ?? []).map((r) => r.ai_score).filter((s) => typeof s === "number") as number[];
  const avg = scores.length ? scores.reduce((a, b) => a + b, 0) / scores.length : null;
  const paragraphsTried = new Set([...(aggGist ?? []).map((r) => r.paragraph_id)]).size;

  await supabase.from("te_student_progress").upsert({
    user_id: userId,
    total_paragraphs_attempted: paragraphsTried,
    total_gist_notes: totalGist,
    total_reconstructions: totalRecon,
    avg_reconstruction_score: avg,
    last_active_at: new Date().toISOString(),
  });
}
