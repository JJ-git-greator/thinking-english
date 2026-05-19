"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import GistEditor, { type GistSelection } from "@/components/GistEditor";
import { createClient } from "@/lib/supabase/client";

interface Props {
  paragraphId: string;
  body: string;
  initial: {
    main_idea_text: string | null;
    supporting_text: string | null;
    main_idea_offset: { start: number; end: number } | null;
    supporting_offset: { start: number; end: number } | null;
  } | null;
}

export default function GistWorkspace({ paragraphId, body, initial }: Props) {
  const router = useRouter();
  const supabase = createClient();
  const [selection, setSelection] = useState<GistSelection>({
    mainIdeaText: initial?.main_idea_text ?? null,
    mainIdeaOffset: initial?.main_idea_offset ?? null,
    supportingText: initial?.supporting_text ?? null,
    supportingOffset: initial?.supporting_offset ?? null,
  });
  const [saving, setSaving] = useState(false);
  const [savedAt, setSavedAt] = useState<Date | null>(null);
  const [error, setError] = useState<string | null>(null);

  const canSave = !!selection.mainIdeaText && !!selection.supportingText;

  async function handleSave() {
    setSaving(true);
    setError(null);
    const { data: userResp } = await supabase.auth.getUser();
    if (!userResp.user) {
      setError("로그인이 만료되었습니다.");
      setSaving(false);
      return;
    }
    const { error: upErr } = await supabase.from("te_gist_notes").upsert(
      {
        user_id: userResp.user.id,
        paragraph_id: paragraphId,
        main_idea_text: selection.mainIdeaText,
        supporting_text: selection.supportingText,
        main_idea_offset: selection.mainIdeaOffset,
        supporting_offset: selection.supportingOffset,
        updated_at: new Date().toISOString(),
      },
      { onConflict: "user_id,paragraph_id" },
    );
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
      <GistEditor
        paragraphBody={body}
        initial={{
          mainIdeaText: selection.mainIdeaText,
          mainIdeaOffset: selection.mainIdeaOffset,
          supportingText: selection.supportingText,
          supportingOffset: selection.supportingOffset,
        }}
        onChange={setSelection}
      />

      {error && (
        <div className="text-sm text-red-600 bg-red-50 border border-red-200 rounded-md p-3">
          {error}
        </div>
      )}

      <div className="flex items-center gap-3">
        <button
          onClick={handleSave}
          disabled={!canSave || saving}
          className="px-5 py-2.5 rounded-md bg-brand-600 text-white font-semibold hover:bg-brand-700 disabled:opacity-50"
        >
          {saving ? "저장 중..." : "Gist 저장"}
        </button>

        {canSave && savedAt && (
          <button
            onClick={() => router.push(`/learn/paragraphs/${paragraphId}/reconstruct`)}
            className="px-5 py-2.5 rounded-md border border-accent-600 text-accent-600 font-semibold hover:bg-blue-50"
          >
            재구성 훈련으로 →
          </button>
        )}

        {savedAt && (
          <span className="text-sm text-gray-500">
            저장됨 ({savedAt.toLocaleTimeString("ko-KR")})
          </span>
        )}
      </div>
    </div>
  );
}
