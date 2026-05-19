import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";

export default async function NewQuestionPage() {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) redirect("/login");
  const { data: me } = await supabase
    .from("te_profiles")
    .select("role")
    .eq("id", userResp.user.id)
    .single();
  const isDirector = me?.role === "director";

  // Load passages user can see (for dropdown)
  const { data: passages } = await supabase
    .from("te_passages")
    .select("id, title, source, org_id")
    .order("created_at", { ascending: false });

  return (
    <div className="space-y-6">
      <div>
        <Link
          href="/academy/library?tab=questions"
          className="text-sm text-gray-500 hover:text-gray-900"
        >
          ← 라이브러리
        </Link>
        <h1 className="text-2xl font-bold mt-2">새 문제 추가</h1>
      </div>

      <form
        action="/api/library/question"
        method="post"
        className="space-y-5 bg-white border rounded-lg p-6"
      >
        <Field label="묶일 지문" hint="문제가 어떤 지문에 기반하는지">
          <select
            name="passage_id"
            className="w-full px-3 py-2 border rounded-md bg-white"
          >
            <option value="">선택 안 함 (독립 문제)</option>
            {(passages ?? []).map((p) => (
              <option key={p.id} value={p.id}>
                {p.title}
                {p.source ? ` — ${p.source}` : ""}
              </option>
            ))}
          </select>
        </Field>

        <div className="grid grid-cols-3 gap-4">
          <Field label="카테고리">
            <select
              name="topic"
              required
              className="w-full px-3 py-2 border rounded-md bg-white"
            >
              <option value="main_idea">주제·요지·제목</option>
              <option value="blank">빈칸 추론</option>
              <option value="vocabulary">어휘 (문맥)</option>
              <option value="grammar">어법</option>
            </select>
          </Field>
          <Field label="난이도">
            <select name="difficulty" className="w-full px-3 py-2 border rounded-md bg-white">
              <option value="">선택 안 함</option>
              <option value="low">하</option>
              <option value="mid">중</option>
              <option value="high">상</option>
              <option value="elite">극상</option>
            </select>
          </Field>
          <Field label="학년">
            <select name="grade_level" className="w-full px-3 py-2 border rounded-md bg-white">
              <option value="">선택 안 함</option>
              {[7, 8, 9, 10, 11, 12].map((g) => (
                <option key={g} value={g}>
                  {g <= 9 ? `중${g - 6}` : `고${g - 9}`}
                </option>
              ))}
            </select>
          </Field>
        </div>

        <Field label="범위">
          <select name="scope" className="w-full px-3 py-2 border rounded-md bg-white">
            <option value="org">우리 학원만 (사설)</option>
            {isDirector && <option value="public">공용 (모든 학원)</option>}
          </select>
        </Field>

        <Field label="문제 본문" hint="예: What is the main idea of the passage?">
          <textarea
            name="prompt"
            required
            rows={3}
            className="w-full px-3 py-2 border rounded-md"
            maxLength={2000}
          />
        </Field>

        <div className="space-y-2">
          <span className="text-sm font-medium text-gray-700">보기 4개</span>
          {[1, 2, 3, 4].map((i) => (
            <div key={i} className="flex items-center gap-2">
              <span className="font-semibold text-gray-500 w-8">{i}.</span>
              <input
                name={`choice_${i}`}
                required
                placeholder={`보기 ${i}`}
                className="flex-1 px-3 py-2 border rounded-md"
                maxLength={500}
              />
            </div>
          ))}
        </div>

        <Field label="정답">
          <select
            name="correct_answer"
            required
            className="w-full px-3 py-2 border rounded-md bg-white"
          >
            <option value="">선택</option>
            <option value="1">1번</option>
            <option value="2">2번</option>
            <option value="3">3번</option>
            <option value="4">4번</option>
          </select>
        </Field>

        <Field label="해설 (선택)" hint="왜 정답인지 짧은 해설 (한국어 OK)">
          <textarea
            name="explanation"
            rows={2}
            className="w-full px-3 py-2 border rounded-md"
            maxLength={1000}
          />
        </Field>

        <div className="flex items-center gap-3">
          <button
            type="submit"
            className="px-5 py-2.5 rounded-md bg-brand-600 text-white font-semibold hover:bg-brand-700"
          >
            문제 저장
          </button>
          <Link
            href="/academy/library?tab=questions"
            className="px-5 py-2.5 rounded-md border border-gray-300 text-gray-700 hover:bg-gray-50"
          >
            취소
          </Link>
        </div>
      </form>
    </div>
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
