"use client";

import { useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/client";

type Tab = "academy" | "email";

export default function LoginForm() {
  const router = useRouter();
  const sp = useSearchParams();
  const supabase = createClient();
  const [tab, setTab] = useState<Tab>("academy");
  const [inviteCode, setInviteCode] = useState("");
  const [studentId, setStudentId] = useState("");
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
      let loginEmail = email;
      if (tab === "academy") {
        if (!inviteCode.trim() || !studentId.trim()) {
          throw new Error("학원 코드와 학생 아이디를 입력해 주세요.");
        }
        const code = inviteCode.trim().toUpperCase();
        loginEmail = `${studentId.trim().toLowerCase()}@${code.toLowerCase()}.academy.local`;
      }

      const { error: signInErr } = await supabase.auth.signInWithPassword({
        email: loginEmail,
        password,
      });

      if (signInErr) {
        if (signInErr.message.toLowerCase().includes("invalid")) {
          throw new Error(
            tab === "academy"
              ? "학원 코드, 학생 아이디, 비밀번호 중 하나가 틀렸습니다."
              : "이메일 또는 비밀번호가 틀렸습니다.",
          );
        }
        throw signInErr;
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
        router.push("/learn/passages");
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err));
    } finally {
      setLoading(false);
    }
  }

  return (
    <main className="min-h-screen flex items-center justify-center px-4 py-8">
      <div className="w-full max-w-md bg-white rounded-xl shadow-sm border p-8 space-y-6">
        <h1 className="text-2xl font-bold">로그인</h1>

        {signedUp && (
          <div className="text-sm bg-brand-50 text-brand-700 border border-brand-200 rounded-md p-3">
            가입이 완료되었습니다. 로그인하세요.
          </div>
        )}

        <div className="grid grid-cols-2 gap-2 p-1 bg-gray-100 rounded-lg">
          <button
            type="button"
            onClick={() => setTab("academy")}
            className={`py-2 rounded-md text-sm font-medium transition ${
              tab === "academy" ? "bg-white shadow-sm" : "text-gray-600"
            }`}
          >
            학원생
          </button>
          <button
            type="button"
            onClick={() => setTab("email")}
            className={`py-2 rounded-md text-sm font-medium transition ${
              tab === "email" ? "bg-white shadow-sm" : "text-gray-600"
            }`}
          >
            이메일 로그인
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
                  className="w-full px-3 py-2 border rounded-md uppercase tracking-wider"
                  required
                />
              </Field>
              <Field label="학생 아이디">
                <input
                  value={studentId}
                  onChange={(e) => setStudentId(e.target.value)}
                  placeholder="stu001"
                  className="w-full px-3 py-2 border rounded-md"
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
                className="w-full px-3 py-2 border rounded-md"
                required
              />
            </Field>
          )}

          <Field label="비밀번호">
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
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
            {loading ? "처리 중..." : "로그인"}
          </button>
        </form>

        <p className="text-sm text-center text-gray-500">
          처음이세요?{" "}
          <Link href="/signup" className="text-brand-600 hover:underline">
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
      <span className="text-sm font-medium text-gray-700">{label}</span>
      {children}
    </label>
  );
}
