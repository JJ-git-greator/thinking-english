import { NextResponse } from "next/server";
import { z } from "zod";
import { adminClient, randomHex } from "@/lib/supabase/admin";

export const runtime = "nodejs";

const Body = z.object({
  mode: z.enum(["academy", "b2c"]),
  invite_code: z.string().max(50).optional(),
  display_name: z.string().min(1).max(40),
  grade_level: z.number().int().min(1).max(12).optional(),
  password: z.string().min(8).max(100),
});

/**
 * 단순화된 가입 API
 * - 학원: 학원 코드 + 이름 + (학년) + 비번  → 합성 이메일 자동 생성
 * - B2C: 이름 + (학년) + 비번  → 합성 이메일 자동 생성
 *
 * 충돌 처리: 같은 학원 / B2C 풀 내에서 display_name unique 강제.
 * 충돌 시 400 + 친절한 한국어 메시지.
 */
export async function POST(req: Request) {
  const admin = adminClient();

  let parsed: z.infer<typeof Body>;
  try {
    parsed = Body.parse(await req.json());
  } catch (err) {
    return NextResponse.json(
      { error: "invalid_body", message: "입력값을 다시 확인해 주세요." },
      { status: 400 },
    );
  }

  const name = parsed.display_name.trim();
  if (!name) {
    return NextResponse.json({ error: "name_required", message: "이름을 입력해 주세요." }, { status: 400 });
  }

  let orgId: string | null = null;
  let codeForEmail = "b2c";

  if (parsed.mode === "academy") {
    if (!parsed.invite_code || !parsed.invite_code.trim()) {
      return NextResponse.json(
        { error: "invite_code_required", message: "학원 코드를 입력해 주세요." },
        { status: 400 },
      );
    }
    const code = parsed.invite_code.trim().toUpperCase();
    const { data: org, error: orgErr } = await admin
      .from("te_organizations")
      .select("id, invite_code")
      .eq("invite_code", code)
      .maybeSingle();
    if (orgErr || !org) {
      return NextResponse.json(
        { error: "org_not_found", message: "일치하는 학원 코드가 없습니다." },
        { status: 400 },
      );
    }
    orgId = org.id;
    codeForEmail = code.toLowerCase();
  }

  // 같은 풀 내에서 display_name unique 체크
  const { data: existing } = await admin
    .from("te_profiles")
    .select("id")
    .eq("display_name", name)
    .filter("org_id", orgId === null ? "is" : "eq", orgId)
    .limit(1);

  if (existing && existing.length > 0) {
    return NextResponse.json(
      {
        error: "name_taken",
        message:
          parsed.mode === "academy"
            ? "이 학원에 같은 이름의 학생이 이미 있어요. 다른 이름(예: 김민지B)으로 가입해 주세요."
            : "이미 사용 중인 이름이에요. 다른 이름으로 가입해 주세요.",
      },
      { status: 400 },
    );
  }

  // 합성 이메일 생성 — unique 보장용 랜덤 6자리 hex
  const synthEmail = `s${randomHex(6)}-${Date.now().toString(36)}@${codeForEmail}.thinking-english.local`;

  const { data: created, error: createErr } = await admin.auth.admin.createUser({
    email: synthEmail,
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
      { error: "create_failed", message: createErr?.message ?? "가입에 실패했어요. 잠시 후 다시 시도해 주세요." },
      { status: 500 },
    );
  }

  return NextResponse.json({ ok: true, synthEmail });
}
