"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/client";

type Tab = "academy" | "b2c";

export default function SignupPage() {
  const router = useRouter();
  const supabase = createClient();
  const [tab, setTab] = useState<Tab>("academy");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [displayName, setDisplayName] = useState("");
  const [inviteCode, setInviteCode] = useState("");
  const [studentId, setStudentId] = useState("");
  const [gradeLevel, setGradeLevel] = useState<number>(10);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setError(null);
    setLoading(true);

    try {
      let orgId: string | null = null;
      let signupEmail = email;
      let role: "student" | "b2c" = "b2c";

      if (tab === "academy") {
        if (!inviteCode.trim()) {
          throw new Error("학원 코드를 입력해 주세요.");
        }
        if (!studentId.trim()) {
          throw new Error("학생 아이디를 입력해 주세요.");
        }
        if (!/^[a-zA-Z0-9_\-]{2,32}$/.test(studentId.trim())) {
          throw new Error(
            "학생 아이디는 영문/숫자/_/- 만 가능 (2~32자). 예: stu001, minji_3",
          );
        }
        const code = inviteCode.trim().toUpperCase();
        const { data: org, error: orgErr } = await supabase
          .from("te_organizations")
          .select("id")
          .eq("invite_code", code)
          .maybeSingle();
        if (orgErr) throw orgErr;
        if (!org) throw new Error("일치하는 학원 코드가 없습니다.");
        orgId = org.id;
        signupEmail = `${studentId.trim().toLowerCase()}@${code.toLowerCase()}.academy.local`;
        role = "student";
      }

      const { error: signUpErr } = await supabase.auth.signUp({
        email: signupEmail,
        password,
        options: {
          data: {
            app: "thinking-english",
            display_name: displayName,
            role,
            org_id: orgId ?? "",
            grade_level: gradeLevel,
            student_id: tab === "academy" ? studentId.trim() : null,
          },
        },
      });
      if (signUpErr) {
        if (signUpErr.message.toLowerCase().includes("already")) {
          throw new Error(
            tab === "academy"
              ? "이미 사용 중인 학생 아이디입니다. 다른 아이디를 써주세요."
              : "이미 가입된 이메일입니다.",
          );
        }
        throw signUpErr;
      }

      router.push("/login?signed_up=1");
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err));
    } finally {
      setLoading(false);
    }
  }

  return (
    <main className="min-h-screen flex items-center justify-center px-4 py-8">
      <div className="w-full max-w-md bg-white rounded-xl shadow-sm border p-8 space-y-6">
        <div className="space-y-1">
          <h1 className="text-2xl font-bold">가입하기</h1>
          <p className="text-sm text-gray-500">
            학원생인지 개인 학습자인지 선택하세요.
          </p>
        </div>

        <div className="grid grid-cols-2 gap-2 p-1 bg-gray-100 rounded-lg">
          <button
            type="button"
            onClick={() => setTab("academy")}
            className={`py-2 rounded-md text-sm font-medium transition ${
              tab === "academy" ? "bg-white shadow-sm" : "text-gray-600"
            }`}
          >
            학원 코드 있어요
          </button>
          <button
            type="button"
            onClick={() => setTab("b2c")}
            className={`py-2 rounded-md text-sm font-medium transition ${
              tab === "b2c" ? "bg-white shadow-sm" : "text-gray-600"
            }`}
          >
            혼자 공부할게요
          </button>
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">
          {tab === "academy" && (
            <>
              <Field label="학원 코드">
                <input
                  value={inviteCode}
                  onChange={(e) => setInviteCode(e.target.value)}
                  placeholder="예: TEST01"
                  className="w-full px-3 py-2 border rounded-md uppercase tracking-wider"
                  required
                />
              </Field>

              <Field label="학생 아이디" hint="영문/숫자/_/- 2~32자. 예: stu001, minji_3">
                <input
                  value={studentId}
                  onChange={(e) => setStudentId(e.target.value)}
                  placeholder="stu001"
                  className="w-full px-3 py-2 border rounded-md"
                  pattern="[a-zA-Z0-9_\-]{2,32}"
                  required
                />
              </Field>
            </>
          )}

          <Field label="이름">
            <input
              value={displayName}
              onChange={(e) => setDisplayName(e.target.value)}
              placeholder="홍길동"
              className="w-full px-3 py-2 border rounded-md"
              required
            />
          </Field>

          <Field label="학년">
            <select
              value={gradeLevel}
              onChange={(e) => setGradeLevel(Number(e.target.value))}
              className="w-full px-3 py-2 border rounded-md bg-white"
            >
              {[7, 8, 9, 10, 11, 12].map((g) => (
                <option key={g} value={g}>
                  {g <= 9 ? `중${g - 6}` : `고${g - 9}`}
                </option>
              ))}
            </select>
          </Field>

          {tab === "b2c" && (
            <Field label="이메일">
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="w-full px-3 py-2 border rounded-md"
                required
              />
            </Field>
          )}

          <Field label="비밀번호 (8자 이상)">
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              minLength={8}
              className="w-full px-3 py-2 border rounded-md"
              required
            />
          </Field>

          {error && <p className="text-sm text-red-600">{error}</p>}

          <button
            type="submit"
            disabled={loading}
            className="w-full py-2.5 rounded-md bg-brand-600 text-white font-semibold hover:bg-brand-700 disabled:opacity-50 transition"
          >
            {loading ? "처리 중..." : "가입하기"}
          </button>
        </form>

        <p className="text-sm text-center text-gray-500">
          이미 가입했어요?{" "}
          <Link href="/login" className="text-brand-600 hover:underline">
            로그인
          </Link>
        </p>
      </div>
    </main>
  );
}

function Field({
  label,
  hint,
  children,
}: {
  label: string;
  hint?: string;
  children: React.ReactNode;
}) {
  return (
    <label className="block space-y-1">
      <span className="text-sm font-medium text-gray-700">{label}</span>
      {children}
      {hint && <span className="block text-xs text-gray-400">{hint}</span>}
    </label>
  );
}
