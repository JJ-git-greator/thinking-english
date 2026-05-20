import { NextResponse } from "next/server";
import { z } from "zod";
import { adminClient } from "@/lib/supabase/admin";

export const runtime = "nodejs";

const Body = z.object({
  mode: z.enum(["academy", "b2c"]),
  invite_code: z.string().max(50).optional(),
  display_name: z.string().min(1).max(40),
});

/**
 * 학원 코드 + 이름 → 합성 이메일 조회 (로그인 직전 단계)
 * 또는 B2C: 이름 → 합성 이메일
 */
export async function POST(req: Request) {
  const admin = adminClient();

  let parsed: z.infer<typeof Body>;
  try {
    parsed = Body.parse(await req.json());
  } catch {
    return NextResponse.json({ error: "invalid_body" }, { status: 400 });
  }

  const name = parsed.display_name.trim();
  let orgId: string | null = null;

  if (parsed.mode === "academy") {
    if (!parsed.invite_code || !parsed.invite_code.trim()) {
      return NextResponse.json(
        { error: "invite_code_required", message: "학원 코드를 입력해 주세요." },
        { status: 400 },
      );
    }
    const code = parsed.invite_code.trim().toUpperCase();
    const { data: org } = await admin
      .from("te_organizations")
      .select("id")
      .eq("invite_code", code)
      .maybeSingle();
    if (!org) {
      return NextResponse.json(
        { error: "org_not_found", message: "일치하는 학원 코드가 없습니다." },
        { status: 400 },
      );
    }
    orgId = org.id;
  }

  // profile에서 display_name + org 매칭
  const { data: profile } = await admin
    .from("te_profiles")
    .select("id, email")
    .eq("display_name", name)
    .filter("org_id", orgId === null ? "is" : "eq", orgId)
    .maybeSingle();

  if (!profile) {
    return NextResponse.json(
      {
        error: "not_found",
        message:
          parsed.mode === "academy"
            ? "학원 코드 또는 이름이 일치하지 않습니다."
            : "일치하는 이름이 없습니다.",
      },
      { status: 404 },
    );
  }

  return NextResponse.json({ email: profile.email });
}
