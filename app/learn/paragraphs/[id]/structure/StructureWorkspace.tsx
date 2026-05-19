"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";

interface Props {
  paragraphId: string;
  paragraphBody: string;
  passageId: string;
  gist: { mainIdea: string; supporting: string };
  initial: {
    structureNotes: string;
    structureDoneAt: string | null;
  };
}

export default function StructureWorkspace({
  paragraphId,
  paragraphBody,
  passageId,
  gist,
  initial,
}: Props) {
  const router = useRouter();
  const supabase = createClient();
  const [notes, setNotes] = useState(initial.structureNotes);
  const [saving, setSaving] = useState(false);
  const [savedAt, setSavedAt] = useState<Date | null>(
    initial.structureDoneAt ? new Date(initial.structureDoneAt) : null,
  );
  const [error, setError] = useState<string | null>(null);

  const canSave = notes.trim().length >= 10;

  async function handleSave() {
    if (!canSave) return;
    setSaving(true);
    setError(null);
    const { data: userResp } = await supabase.auth.getUser();
    if (!userResp.user) {
      setError("로그인이 만료되었습니다.");
      setSaving(false);
      return;
    }
    const { error: upErr } = await supabase
      .from("te_gist_notes")
      .update({
        structure_notes: notes.trim(),
        structure_done_at: new Date().toISOString(),
      })
      .eq("user_id", userResp.user.id)
      .eq("paragraph_id", paragraphId);

    if (upErr) {
      setError(upErr.message);
      setSaving(false);
      return;
    }
    setSavedAt(new Date());
    setSaving(false);
  }

  return (
    <div className="space-y-5">
      <div className="bg-white border rounded-lg p-5">
        <p className="text-gray-800 leading-relaxed whitespace-pre-wrap">
          {paragraphBody}
        </p>
      </div>

      <div className="bg-brand-50 border border-brand-200 rounded-lg p-4 space-y-2 text-sm">
        <div className="font-semibold text-brand-700">1회독에서 잡은 두 문장</div>
        <p className="text-gray-800">
          <span className="text-xs font-semibold text-brand-700 mr-2">메인</span>
          {gist.mainIdea}
        </p>
        <p className="text-gray-800">
          <span className="text-xs font-semibold text-brand-700 mr-2">서포팅</span>
          {gist.supporting}
        </p>
      </div>

      <div className="bg-sky-50 border border-sky-200 rounded-lg p-4 text-sm space-y-2">
        <div className="font-semibold text-sky-800">무엇을 적으면 되나요</div>
        <ul className="text-gray-700 space-y-1 list-disc ml-5">
          <li>
            <b>주어가 무엇인지</b> — 첫 명사를 찾고, 그 명사가 단수인지 복수인지.
          </li>
          <li>
            <b>동사의 형태</b> — 주어와 일치하는지, 시제와 능동/수동이 자연스러운지.
          </li>
          <li>
            <b>문장이 어떻게 늘어났는지</b> — 한 문장에 의미가 더 붙어 있다면 어떤
            구조(to부정사·관계절·접속사 등)로 늘어났는지.
          </li>
          <li>
            메인 아이디어를 만드는 핵심 문장을 짧게 인용하고, 그 문장의 구조에서
            <b> 의미가 어떻게 만들어지는지</b> 한 줄로 적어보세요.
          </li>
        </ul>
      </div>

      <div className="space-y-2">
        <label className="block text-sm font-medium text-gray-700">
          이 단락의 구조 메모 (한국어로 적어도 OK, 10자 이상)
        </label>
        <textarea
          value={notes}
          onChange={(e) => setNotes(e.target.value)}
          rows={8}
          placeholder={`예:
- 메인 문장 주어는 "this hidden cost" (단수), 동사 "matters"가 단수 일치
- 두 번째 문장은 "tries to study"처럼 to부정사로 의미가 한 번 더 늘어남
- 마지막 문장은 도치 없이 주어+동사+목적어로 평범하게 흐름`}
          className="w-full px-4 py-3 border rounded-lg leading-relaxed font-mono text-sm"
          maxLength={3000}
        />
        <div className="flex items-center justify-between text-sm">
          <span className="text-gray-500">{notes.trim().length}자</span>
          {savedAt && (
            <span className="text-green-700 font-medium">
              ✓ 2회독 완료 ({savedAt.toLocaleTimeString("ko-KR")})
            </span>
          )}
        </div>
      </div>

      {error && (
        <div className="text-sm text-red-600 bg-red-50 border border-red-200 rounded-md p-2">
          {error}
        </div>
      )}

      <div className="flex items-center gap-3">
        <button
          onClick={handleSave}
          disabled={!canSave || saving}
          className="px-5 py-2.5 rounded-md bg-brand-600 text-white font-semibold hover:bg-brand-700 disabled:opacity-50"
        >
          {saving ? "저장 중..." : "2회독 저장"}
        </button>
        {savedAt && (
          <button
            onClick={() =>
              router.push(`/learn/paragraphs/${paragraphId}/reconstruct`)
            }
            className="px-5 py-2.5 rounded-md border border-accent-600 text-accent-600 font-semibold hover:bg-blue-50"
          >
            3회독 (재구성)으로 →
          </button>
        )}
      </div>
    </div>
  );
}
