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
  const [inviteCode, setInviteCode] = useState("");
  const [displayName, setDisplayName] = useState("");
  const [email, setEmail] = useState("");
  const [gradeLevel, setGradeLevel] = useState<number>(10);
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setError(null);
    setLoading(true);
    try {
      const resp = await fetch("/api/auth/signup", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          mode: tab,
          invite_code: tab === "academy" ? inviteCode : undefined,
          email: tab === "b2c" ? email : undefined,
          display_name: displayName,
          grade_level: gradeLevel,
          password,
        }),
      });
      const data = await resp.json();
      if (!resp.ok) {
        throw new Error(data.message || data.error || "가입에 실패했어요.");
      }

      // 가입 직후 자동 로그인 시도
      const { error: signInErr } = await supabase.auth.signInWithPassword({
        email: data.email,
        password,
      });
      if (signInErr) {
        // 자동 로그인 실패해도 가입은 됨 → 로그인 페이지로
        router.push("/login?signed_up=1");
        return;
      }

      // 자동 로그인 성공 → 학습 화면으로
      router.push(tab === "academy" ? "/learn/review" : "/learn/review");
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err));
    } finally {
      setLoading(false);
    }
  }

  return (
    <main className="min-h-screen flex items-center justify-center px-4 py-8 bg-gradient-to-br from-amber-50 via-white to-blue-50">
      <div className="w-full max-w-md bg-white rounded-2xl shadow-lg border border-gray-100 p-8 space-y-6">
        <div className="space-y-1">
          <h1 className="text-2xl font-bold">가입하기</h1>
          <p className="text-sm text-gray-500">이름과 비밀번호만 있으면 시작할 수 있어요.</p>
        </div>

        <div className="grid grid-cols-2 gap-2 p-1 bg-gray-100 rounded-lg">
          <button
            type="button"
            onClick={() => setTab("academy")}
            className={`py-2 rounded-md text-sm font-semibold transition ${
              tab === "academy" ? "bg-white shadow-sm text-gray-900" : "text-gray-500"
            }`}
          >
            학원 코드 있어요
          </button>
          <button
            type="button"
            onClick={() => setTab("b2c")}
            className={`py-2 rounded-md text-sm font-semibold transition ${
              tab === "b2c" ? "bg-white shadow-sm text-gray-900" : "text-gray-500"
            }`}
          >
            혼자 공부할게요
          </button>
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">
          {tab === "academy" && (
            <Field label="학원 코드" hint="선생님이 알려준 학원 코드를 입력하세요">
              <input
                value={inviteCode}
                onChange={(e) => setInviteCode(e.target.value)}
                placeholder="예: TEST01"
                className="w-full px-3 py-2.5 border rounded-lg uppercase tracking-wider"
                required
              />
            </Field>
          )}

          {tab === "b2c" && (
            <Field label="이메일" hint="로그인할 때 사용해요. 비밀번호 찾기에도 필요합니다.">
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="you@example.com"
                className="w-full px-3 py-2.5 border rounded-lg"
                required
              />
            </Field>
          )}

          <Field
            label="이름"
            hint={
              tab === "academy"
                ? "학원에서 같은 이름이 있으면 차단됩니다. 끝에 글자를 붙여 구분해 주세요."
                : "본인이 부르고 싶은 이름이면 충분해요."
            }
          >
            <input
              value={displayName}
              onChange={(e) => setDisplayName(e.target.value)}
              placeholder="예: 김민지"
              className="w-full px-3 py-2.5 border rounded-lg"
              maxLength={40}
              required
            />
          </Field>

          <Field label="학년">
            <select
              value={gradeLevel}
              onChange={(e) => setGradeLevel(Number(e.target.value))}
              className="w-full px-3 py-2.5 border rounded-lg bg-white"
            >
              {[7, 8, 9, 10, 11, 12].map((g) => (
                <option key={g} value={g}>
                  {g <= 9 ? `중${g - 6}` : `고${g - 9}`}
                </option>
              ))}
            </select>
          </Field>

          <Field label="비밀번호" hint="8자 이상">
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              minLength={8}
              className="w-full px-3 py-2.5 border rounded-lg"
              required
            />
          </Field>

          {error && (
            <div className="text-sm text-red-600 bg-red-50 border border-red-200 rounded-md p-2.5">
              {error}
            </div>
          )}

          <button
            type="submit"
            disabled={loading}
            className="w-full py-3 rounded-lg bg-brand-600 text-white font-bold hover:bg-brand-700 disabled:opacity-50 transition"
          >
            {loading ? "처리 중..." : "가입하기"}
          </button>
        </form>

        <p className="text-sm text-center text-gray-500">
          이미 가입했어요?{" "}
          <Link href="/login" className="text-brand-600 hover:underline font-medium">
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
      <span className="text-sm font-semibold text-gray-700">{label}</span>
      {children}
      {hint && <span className="block text-xs text-gray-400 leading-snug">{hint}</span>}
    </label>
  );
}
