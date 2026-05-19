import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";

export default async function NewPassagePage() {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) redirect("/login");
  const { data: me } = await supabase
    .from("te_profiles")
    .select("role")
    .eq("id", userResp.user.id)
    .single();
  const isDirector = me?.role === "director";

  return (
    <div className="space-y-6">
      <div>
        <Link
          href="/academy/library"
          className="text-sm text-gray-500 hover:text-gray-900"
        >
          ← 라이브러리
        </Link>
        <h1 className="text-2xl font-bold mt-2">새 지문 추가</h1>
      </div>

      <form action="/api/library/passage" method="post" className="space-y-5 bg-white border rounded-lg p-6">
        <Field label="제목" hint="예: The Hidden Cost of Free Choice">
          <input
            name="title"
            required
            className="w-full px-3 py-2 border rounded-md"
            maxLength={200}
          />
        </Field>

        <div className="grid grid-cols-2 gap-4">
          <Field label="출처 (선택)" hint="예: EBS 모의, 본교 중간고사">
            <input
              name="source"
              className="w-full px-3 py-2 border rounded-md"
              maxLength={100}
            />
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

        <div className="grid grid-cols-2 gap-4">
          <Field label="난이도">
            <select name="difficulty" className="w-full px-3 py-2 border rounded-md bg-white">
              <option value="">선택 안 함</option>
              <option value="low">하</option>
              <option value="mid">중</option>
              <option value="high">상</option>
              <option value="elite">극상</option>
            </select>
          </Field>
          <Field label="범위">
            <select name="scope" className="w-full px-3 py-2 border rounded-md bg-white">
              <option value="org">우리 학원만 (사설)</option>
              {isDirector && <option value="public">공용 (모든 학원)</option>}
            </select>
          </Field>
        </div>

        <Field
          label="인트로 (1~2 문장)"
          hint="지문 도입부. 단락 위에 표시되는 짧은 설명. 영어로 작성."
        >
          <textarea
            name="body"
            required
            rows={3}
            className="w-full px-3 py-2 border rounded-md"
            placeholder="Behavioral economists have long studied how people make decisions..."
            maxLength={1000}
          />
        </Field>

        <Field
          label="단락들"
          hint="단락 사이에 빈 줄 한 줄을 두면 자동으로 단락이 나뉩니다. 영어 본문 그대로 복붙해도 OK."
        >
          <textarea
            name="paragraphs"
            required
            rows={14}
            className="w-full px-3 py-2 border rounded-md font-mono text-sm"
            placeholder={`When shoppers walk into a store offering 24 different kinds of jam, they often pause longer at the display than those who see only 6 kinds...

This phenomenon, sometimes called "choice overload," reveals a quiet trade-off...

For students, this hidden cost matters more than it seems...`}
            maxLength={20000}
          />
        </Field>

        <div className="flex items-center gap-3">
          <button
            type="submit"
            className="px-5 py-2.5 rounded-md bg-brand-600 text-white font-semibold hover:bg-brand-700"
          >
            지문 저장
          </button>
          <Link
            href="/academy/library"
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
