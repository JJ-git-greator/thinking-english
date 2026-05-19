import { NextResponse } from "next/server";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";

export const runtime = "nodejs";

const Body = z.object({
  passage_id: z.string().uuid().optional(),
  topic: z.enum(["main_idea", "blank", "vocabulary", "grammar"]),
  difficulty: z.enum(["low", "mid", "high", "elite", ""]).optional(),
  grade_level: z.string().optional(),
  scope: z.enum(["org", "public"]),
  prompt: z.string().min(1).max(2000),
  choice_1: z.string().min(1).max(500),
  choice_2: z.string().min(1).max(500),
  choice_3: z.string().min(1).max(500),
  choice_4: z.string().min(1).max(500),
  correct_answer: z.enum(["1", "2", "3", "4"]),
  explanation: z.string().max(1000).optional(),
});

export async function POST(req: Request) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) return NextResponse.redirect(new URL("/login", req.url));
  const userId = userResp.user.id;

  const { data: me } = await supabase
    .from("te_profiles")
    .select("org_id, role")
    .eq("id", userId)
    .single();

  if (!me || (me.role !== "director" && me.role !== "instructor")) {
    return NextResponse.redirect(new URL("/learn/passages", req.url));
  }

  const form = await req.formData();
  const passageRaw = form.get("passage_id") as string | null;

  let parsed: z.infer<typeof Body>;
  try {
    parsed = Body.parse({
      passage_id: passageRaw && passageRaw.length > 0 ? passageRaw : undefined,
      topic: form.get("topic"),
      difficulty: (form.get("difficulty") as string) || "",
      grade_level: form.get("grade_level") || undefined,
      scope: form.get("scope") ?? "org",
      prompt: form.get("prompt"),
      choice_1: form.get("choice_1"),
      choice_2: form.get("choice_2"),
      choice_3: form.get("choice_3"),
      choice_4: form.get("choice_4"),
      correct_answer: form.get("correct_answer"),
      explanation: form.get("explanation")?.toString() || undefined,
    });
  } catch (err) {
    return NextResponse.redirect(
      new URL("/academy/library/questions/new?err=invalid", req.url),
    );
  }

  if (parsed.scope === "public" && me.role !== "director") {
    return NextResponse.redirect(
      new URL("/academy/library/questions/new?err=forbidden", req.url),
    );
  }

  const orgId = parsed.scope === "public" ? null : me.org_id;

  const choices = [1, 2, 3, 4].map((i) => ({
    key: String(i),
    text: (parsed as any)[`choice_${i}`] as string,
  }));

  const { error } = await supabase.from("te_questions").insert({
    passage_id: parsed.passage_id ?? null,
    topic: parsed.topic,
    prompt: parsed.prompt,
    choices,
    correct_answer: parsed.correct_answer,
    explanation: parsed.explanation || null,
    difficulty: parsed.difficulty || null,
    grade_level: parsed.grade_level ? Number(parsed.grade_level) : null,
    org_id: orgId,
    created_by: userId,
  });

  if (error) {
    return NextResponse.redirect(
      new URL(
        `/academy/library/questions/new?err=${encodeURIComponent(error.message)}`,
        req.url,
      ),
    );
  }

  return NextResponse.redirect(
    new URL("/academy/library?tab=questions&added=question", req.url),
  );
}
