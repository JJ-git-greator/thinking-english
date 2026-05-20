import { NextResponse } from "next/server";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";
import { gradeGist } from "@/lib/claude/grade-gist";

export const runtime = "nodejs";

const Body = z.object({
  paragraphId: z.string().uuid(),
  mainReasoning: z.string().max(500).optional(),
  supportingReasoning: z.string().max(500).optional(),
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

  // Fetch paragraph
  const { data: paragraph } = await supabase
    .from("te_paragraphs")
    .select("id, body")
    .eq("id", parsed.paragraphId)
    .maybeSingle();
  if (!paragraph) {
    return NextResponse.json({ error: "paragraph_not_found" }, { status: 404 });
  }

  // Fetch user's gist note
  const { data: gist } = await supabase
    .from("te_gist_notes")
    .select("id, main_idea_text, supporting_text")
    .eq("user_id", userId)
    .eq("paragraph_id", paragraph.id)
    .maybeSingle();
  if (!gist?.main_idea_text || !gist?.supporting_text) {
    return NextResponse.json(
      { error: "gist_required", message: "두 문장을 먼저 선택하고 저장해 주세요." },
      { status: 400 },
    );
  }

  // Grade
  let result;
  try {
    result = await gradeGist({
      paragraphBody: paragraph.body,
      studentMainText: gist.main_idea_text,
      studentSupportingText: gist.supporting_text,
      mainReasoning: parsed.mainReasoning,
      supportingReasoning: parsed.supportingReasoning,
      preferSmart: parsed.preferSmart,
    });
  } catch (err) {
    console.error("[grade-gist]", err);
    return NextResponse.json(
      { error: "grading_failed", message: err instanceof Error ? err.message : "unknown" },
      { status: 500 },
    );
  }

  // Save to gist note
  await supabase
    .from("te_gist_notes")
    .update({
      main_reasoning: parsed.mainReasoning ?? null,
      supporting_reasoning: parsed.supportingReasoning ?? null,
      ai_evaluation: result,
      ai_model: result.model,
      evaluated_at: new Date().toISOString(),
    })
    .eq("id", gist.id);

  return NextResponse.json(result);
}
