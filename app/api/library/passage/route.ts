import { NextResponse } from "next/server";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";

export const runtime = "nodejs";

const Body = z.object({
  title: z.string().min(1).max(200),
  source: z.string().max(100).optional(),
  grade_level: z.string().optional(),
  difficulty: z.enum(["low", "mid", "high", "elite", ""]).optional(),
  scope: z.enum(["org", "public"]),
  body: z.string().min(1).max(2000),
  paragraphs: z.string().min(1).max(20000),
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
  let parsed: z.infer<typeof Body>;
  try {
    parsed = Body.parse({
      title: form.get("title"),
      source: form.get("source") || undefined,
      grade_level: form.get("grade_level") || undefined,
      difficulty: (form.get("difficulty") as string) || "",
      scope: form.get("scope") ?? "org",
      body: form.get("body"),
      paragraphs: form.get("paragraphs"),
    });
  } catch (err) {
    return NextResponse.redirect(
      new URL("/academy/library/passages/new?err=invalid", req.url),
    );
  }

  // Only directors can post to public scope
  if (parsed.scope === "public" && me.role !== "director") {
    return NextResponse.redirect(
      new URL("/academy/library/passages/new?err=forbidden", req.url),
    );
  }

  const orgId = parsed.scope === "public" ? null : me.org_id;

  // Split paragraphs by one or more blank lines
  const paras = parsed.paragraphs
    .split(/\n\s*\n+/)
    .map((p) => p.trim())
    .filter((p) => p.length > 0);

  if (paras.length === 0) {
    return NextResponse.redirect(
      new URL("/academy/library/passages/new?err=no_paragraphs", req.url),
    );
  }

  // Insert passage
  const { data: passage, error: pErr } = await supabase
    .from("te_passages")
    .insert({
      title: parsed.title,
      body: parsed.body,
      source: parsed.source || null,
      grade_level: parsed.grade_level ? Number(parsed.grade_level) : null,
      difficulty: parsed.difficulty || null,
      org_id: orgId,
      created_by: userId,
    })
    .select("id")
    .single();

  if (pErr || !passage) {
    return NextResponse.redirect(
      new URL(
        `/academy/library/passages/new?err=${encodeURIComponent(pErr?.message ?? "save_failed")}`,
        req.url,
      ),
    );
  }

  // Insert paragraphs
  const paraRows = paras.map((body, i) => ({
    passage_id: passage.id,
    ord: i,
    body,
  }));
  const { error: parErr } = await supabase.from("te_paragraphs").insert(paraRows);
  if (parErr) {
    // Rollback passage best-effort
    await supabase.from("te_passages").delete().eq("id", passage.id);
    return NextResponse.redirect(
      new URL(
        `/academy/library/passages/new?err=${encodeURIComponent(parErr.message)}`,
        req.url,
      ),
    );
  }

  return NextResponse.redirect(
    new URL("/academy/library?tab=passages&added=passage", req.url),
  );
}
