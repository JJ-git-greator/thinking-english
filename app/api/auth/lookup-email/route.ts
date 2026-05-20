import { NextResponse } from "next/server";
import { z } from "zod";
import { adminClient } from "@/lib/supabase/admin";

export const runtime = "nodejs";

const Body = z.object({
  invite_code: z.string().max(50),
  display_name: z.string().min(1).max(40),
});

/**
 * 학원 코드 + 이름 → 합성 이메일 조회 (학원생 로그인 직전 단계)
 * B2C는 사용자 이메일로 직접 로그인하므로 이 API 사용 안 함.
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

  const { data: profile } = await admin
    .from("te_profiles")
    .select("id, email")
    .eq("display_name", name)
    .eq("org_id", org.id)
    .maybeSingle();

  if (!profile) {
    return NextResponse.json(
      { error: "not_found", message: "학원 코드 또는 이름이 일치하지 않습니다." },
      { status: 404 },
    );
  }

  return NextResponse.json({ email: profile.email });
}
