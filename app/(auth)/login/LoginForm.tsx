"use client";

import { useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/client";

type Tab = "academy" | "b2c";

export default function LoginForm() {
  const router = useRouter();
  const sp = useSearchParams();
  const supabase = createClient();
  const [tab, setTab] = useState<Tab>("academy");
  const [inviteCode, setInviteCode] = useState("");
  const [displayName, setDisplayName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const signedUp = sp.get("signed_up") === "1";

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setError(null);
    setLoading(true);

    try {
      let loginEmail: string;

      if (tab === "academy") {
        // 학원 코드 + 이름 → 합성 이메일 조회
        const lookup = await fetch("/api/auth/lookup-email", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            invite_code: inviteCode,
            display_name: displayName,
          }),
        });
        const lookupData = await lookup.json();
        if (!lookup.ok) {
          throw new Error(lookupData.message || lookupData.error || "로그인 실패");
        }
        loginEmail = lookupData.email;
      } else {
        // B2C: 이메일 직접 사용
        loginEmail = email.trim().toLowerCase();
      }

      const { error: signInErr } = await supabase.auth.signInWithPassword({
        email: loginEmail,
        password,
      });

      if (signInErr) {
        throw new Error(
          tab === "academy"
            ? "비밀번호가 일치하지 않아요."
            : "이메일 또는 비밀번호가 일치하지 않아요.",
        );
      }

      const { data: userResp } = await supabase.auth.getUser();
      if (!userResp.user) {
        throw new Error("로그인 정보를 확인하지 못했습니다.");
      }
      const { data: profile } = await supabase
        .from("te_profiles")
        .select("role")
        .eq("id", userResp.user.id)
        .maybeSingle();
      const role = profile?.role ?? "b2c";
      if (role === "director" || role === "instructor") {
        router.push("/academy/dashboard");
      } else {
        router.push("/learn/review");
      }
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
          <h1 className="text-2xl font-bold">로그인</h1>
          <p className="text-sm text-gray-500">
            {tab === "academy"
              ? "학원 코드와 이름·비밀번호로 들어오세요."
              : "이메일·비밀번호로 들어오세요."}
          </p>
        </div>

        {signedUp && (
          <div className="text-sm bg-brand-50 text-brand-700 border border-brand-200 rounded-md p-3">
            가입이 완료되었습니다. 같은 정보로 로그인하세요.
          </div>
        )}

        <div className="grid grid-cols-2 gap-2 p-1 bg-gray-100 rounded-lg">
          <button
            type="button"
            onClick={() => setTab("academy")}
            className={`py-2 rounded-md text-sm font-semibold transition ${
              tab === "academy" ? "bg-white shadow-sm text-gray-900" : "text-gray-500"
            }`}
          >
            학원생
          </button>
          <button
            type="button"
            onClick={() => setTab("b2c")}
            className={`py-2 rounded-md text-sm font-semibold transition ${
              tab === "b2c" ? "bg-white shadow-sm text-gray-900" : "text-gray-500"
            }`}
          >
            개인 학습자
          </button>
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">
          {tab === "academy" ? (
            <>
              <Field label="학원 코드">
                <input
                  value={inviteCode}
                  onChange={(e) => setInviteCode(e.target.value)}
                  placeholder="예: TEST01"
                  className="w-full px-3 py-2.5 border rounded-lg uppercase tracking-wider"
                  required
                />
              </Field>
              <Field label="이름">
                <input
                  value={displayName}
                  onChange={(e) => setDisplayName(e.target.value)}
                  placeholder="예: 김민지"
                  className="w-full px-3 py-2.5 border rounded-lg"
                  maxLength={40}
                  required
                />
              </Field>
            </>
          ) : (
            <Field label="이메일">
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

          <Field label="비밀번호">
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
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
            {loading ? "처리 중..." : "로그인"}
          </button>
        </form>

        <p className="text-sm text-center text-gray-500">
          처음이세요?{" "}
          <Link href="/signup" className="text-brand-600 hover:underline font-medium">
            가입하기
          </Link>
        </p>
      </div>
    </main>
  );
}

function Field({ label, children }: { label: string; children: React.ReactNode }) {
  return (
    <label className="block space-y-1">
      <span className="text-sm font-semibold text-gray-700">{label}</span>
      {children}
    </label>
  );
}
