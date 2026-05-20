import { NextResponse } from "next/server";
import { z } from "zod";
import { adminClient, randomHex } from "@/lib/supabase/admin";

export const runtime = "nodejs";

const Body = z.object({
  mode: z.enum(["academy", "b2c"]),
  invite_code: z.string().max(50).optional(),
  display_name: z.string().min(1).max(40),
  email: z.string().email().optional(),       // B2C 전용
  grade_level: z.number().int().min(1).max(12).optional(),
  password: z.string().min(8).max(100),
});

/**
 * 가입 API
 * - 학원: 학원 코드 + 이름 + (학년) + 비번 → 합성 이메일 자동 생성. 학원 내 이름 unique 강제.
 * - B2C: 이메일 + 이름 + (학년) + 비번 → 사용자 이메일 그대로 사용. 이메일 unique는 Supabase Auth가 보장.
 */
export async function POST(req: Request) {
  const admin = adminClient();

  let parsed: z.infer<typeof Body>;
  try {
    parsed = Body.parse(await req.json());
  } catch {
    return NextResponse.json(
      { error: "invalid_body", message: "입력값을 다시 확인해 주세요." },
      { status: 400 },
    );
  }

  const name = parsed.display_name.trim();
  if (!name) {
    return NextResponse.json(
      { error: "name_required", message: "이름을 입력해 주세요." },
      { status: 400 },
    );
  }

  let orgId: string | null = null;
  let signupEmail: string;

  if (parsed.mode === "academy") {
    // 학원 코드 검증
    if (!parsed.invite_code || !parsed.invite_code.trim()) {
      return NextResponse.json(
        { error: "invite_code_required", message: "학원 코드를 입력해 주세요." },
        { status: 400 },
      );
    }
    const code = parsed.invite_code.trim().toUpperCase();
    const { data: org } = await admin
      .from("te_organizations")
      .select("id, invite_code")
      .eq("invite_code", code)
      .maybeSingle();
    if (!org) {
      return NextResponse.json(
        { error: "org_not_found", message: "일치하는 학원 코드가 없습니다." },
        { status: 400 },
      );
    }
    orgId = org.id;

    // 학원 내 이름 unique 체크
    const { data: existing } = await admin
      .from("te_profiles")
      .select("id")
      .eq("display_name", name)
      .eq("org_id", orgId)
      .limit(1);
    if (existing && existing.length > 0) {
      return NextResponse.json(
        {
          error: "name_taken",
          message:
            "이 학원에 같은 이름의 학생이 이미 있어요. 다른 이름(예: 김민지B)으로 가입해 주세요.",
        },
        { status: 400 },
      );
    }

    // 합성 이메일 (학생은 절대 안 봄)
    signupEmail = `s${randomHex(6)}-${Date.now().toString(36)}@${code.toLowerCase()}.thinking-english.local`;
  } else {
    // B2C: 사용자 이메일 필수
    if (!parsed.email) {
      return NextResponse.json(
        { error: "email_required", message: "이메일을 입력해 주세요." },
        { status: 400 },
      );
    }
    signupEmail = parsed.email.trim().toLowerCase();

    // 같은 이메일로 이미 가입했는지 (supabase가 알아서 체크하지만 사용자 친화 메시지)
    const { data: existing } = await admin
      .from("te_profiles")
      .select("id")
      .eq("email", signupEmail)
      .limit(1);
    if (existing && existing.length > 0) {
      return NextResponse.json(
        { error: "email_taken", message: "이미 가입된 이메일이에요." },
        { status: 400 },
      );
    }
  }

  const { data: created, error: createErr } = await admin.auth.admin.createUser({
    email: signupEmail,
    password: parsed.password,
    email_confirm: true,
    user_metadata: {
      app: "thinking-english",
      display_name: name,
      role: parsed.mode === "academy" ? "student" : "b2c",
      org_id: orgId ?? "",
      grade_level: parsed.grade_level ?? null,
    },
  });

  if (createErr || !created.user) {
    return NextResponse.json(
      {
        error: "create_failed",
        message: createErr?.message ?? "가입에 실패했어요. 잠시 후 다시 시도해 주세요.",
      },
      { status: 500 },
    );
  }

  return NextResponse.json({ ok: true, email: signupEmail });
}
