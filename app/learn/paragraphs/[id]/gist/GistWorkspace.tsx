"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import GistEditor, { type GistSelection } from "@/components/GistEditor";
import { createClient } from "@/lib/supabase/client";

interface Evaluation {
  overall: number;
  main_accuracy: number;
  supporting_accuracy: number;
  reasoning_quality: number;
  feedback: {
    main: string;
    supporting: string;
    reasoning?: string;
    better_main?: string;
    better_supporting?: string;
  };
  next_step: string;
  model?: string;
}

interface Props {
  paragraphId: string;
  body: string;
  initial: {
    main_idea_text: string | null;
    supporting_text: string | null;
    main_idea_offset: { start: number; end: number } | null;
    supporting_offset: { start: number; end: number } | null;
    main_reasoning?: string | null;
    supporting_reasoning?: string | null;
    ai_evaluation?: Evaluation | null;
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
  const [mainReasoning, setMainReasoning] = useState(initial?.main_reasoning ?? "");
  const [supportingReasoning, setSupportingReasoning] = useState(
    initial?.supporting_reasoning ?? "",
  );
  const [saving, setSaving] = useState(false);
  const [savedAt, setSavedAt] = useState<Date | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [coaching, setCoaching] = useState(false);
  const [evaluation, setEvaluation] = useState<Evaluation | null>(
    initial?.ai_evaluation ?? null,
  );

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
        main_reasoning: mainReasoning.trim() || null,
        supporting_reasoning: supportingReasoning.trim() || null,
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

  async function handleCoaching() {
    if (!canSave) {
      setError("두 문장을 먼저 선택해 주세요.");
      return;
    }
    setCoaching(true);
    setError(null);

    // Save current state first (근거 포함)
    await handleSave();

    try {
      const resp = await fetch("/api/grade/gist", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          paragraphId,
          mainReasoning: mainReasoning.trim() || undefined,
          supportingReasoning: supportingReasoning.trim() || undefined,
        }),
      });
      const data = await resp.json();
      if (!resp.ok) {
        throw new Error(data.message || data.error || "선택 검토에 실패했어요.");
      }
      setEvaluation(data);
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err));
    } finally {
      setCoaching(false);
    }
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

      {canSave && (
        <div className="grid sm:grid-cols-2 gap-3 bg-gray-50 border rounded-lg p-4">
          <div className="space-y-1">
            <label className="block text-sm font-medium text-gray-700">
              왜 이 문장을 메인으로 골랐나요? <span className="text-gray-400 text-xs">(선택)</span>
            </label>
            <input
              value={mainReasoning}
              onChange={(e) => setMainReasoning(e.target.value)}
              placeholder="예: 첫 문장이 전체 주장을 압축해서 던지고 있어서"
              className="w-full px-3 py-2 border rounded-md text-sm"
              maxLength={500}
            />
          </div>
          <div className="space-y-1">
            <label className="block text-sm font-medium text-gray-700">
              왜 이 문장이 서포팅인가요? <span className="text-gray-400 text-xs">(선택)</span>
            </label>
            <input
              value={supportingReasoning}
              onChange={(e) => setSupportingReasoning(e.target.value)}
              placeholder="예: 메인의 이유·예시를 구체적으로 들어주고 있어서"
              className="w-full px-3 py-2 border rounded-md text-sm"
              maxLength={500}
            />
          </div>
        </div>
      )}

      {error && (
        <div className="text-sm text-red-600 bg-red-50 border border-red-200 rounded-md p-3">
          {error}
        </div>
      )}

      <div className="flex items-center gap-3 flex-wrap">
        <button
          onClick={handleSave}
          disabled={!canSave || saving}
          className="px-5 py-2.5 rounded-md bg-brand-600 text-white font-semibold hover:bg-brand-700 disabled:opacity-50"
        >
          {saving ? "저장 중..." : "Gist 저장"}
        </button>

        <button
          onClick={handleCoaching}
          disabled={!canSave || coaching || saving}
          className="px-5 py-2.5 rounded-md border-2 border-accent-600 text-accent-600 font-semibold hover:bg-blue-50 disabled:opacity-50"
        >
          {coaching ? "검토 중..." : "선택 검토 받기"}
        </button>

        {canSave && (savedAt || evaluation) && (
          <button
            onClick={() => router.push(`/learn/paragraphs/${paragraphId}/structure`)}
            className="px-5 py-2.5 rounded-md border border-gray-300 text-gray-700 font-medium hover:bg-gray-50"
          >
            2회독 (Structure)으로 →
          </button>
        )}

        {savedAt && (
          <span className="text-sm text-gray-500">
            저장됨 ({savedAt.toLocaleTimeString("ko-KR")})
          </span>
        )}
      </div>

      {evaluation && <EvaluationPanel evaluation={evaluation} />}
    </div>
  );
}

function EvaluationPanel({ evaluation }: { evaluation: Evaluation }) {
  const e = evaluation;
  return (
    <div className="bg-white border-2 border-accent-600 rounded-lg p-6 space-y-4">
      <div className="flex items-baseline gap-3">
        <span className="text-5xl font-bold text-accent-600">{e.overall}</span>
        <span className="text-gray-500">/ 100 — 선택 검토 결과</span>
      </div>

      <div className="grid grid-cols-3 gap-3 text-center">
        <SubScore label="메인 적합도" value={e.main_accuracy} />
        <SubScore label="서포팅 적합도" value={e.supporting_accuracy} />
        <SubScore label="근거의 합리성" value={e.reasoning_quality} />
      </div>

      <div className="space-y-3 text-sm">
        <FeedbackItem title="메인 선택에 대해" body={e.feedback.main} />
        {e.feedback.better_main && (
          <BetterCandidate label="더 메인에 어울리는 문장" quote={e.feedback.better_main} />
        )}
        <FeedbackItem title="서포팅 선택에 대해" body={e.feedback.supporting} />
        {e.feedback.better_supporting && (
          <BetterCandidate label="더 서포팅에 어울리는 문장" quote={e.feedback.better_supporting} />
        )}
        {e.feedback.reasoning && (
          <FeedbackItem title="내 근거에 대해" body={e.feedback.reasoning} />
        )}
      </div>

      <div className="bg-brand-50 border border-brand-200 rounded-md p-3 text-sm">
        <div className="font-semibold text-brand-700 mb-1">다음 단락에서는</div>
        <p className="text-gray-700">{e.next_step}</p>
      </div>

      {/* 엔진 표시는 디버그용이라 노출하지 않음 */}
    </div>
  );
}

function SubScore({ label, value }: { label: string; value: number }) {
  return (
    <div className="bg-gray-50 rounded-md py-2">
      <div className="text-lg font-semibold">
        {value}
        <span className="text-xs text-gray-400">/100</span>
      </div>
      <div className="text-xs text-gray-500">{label}</div>
    </div>
  );
}

function FeedbackItem({ title, body }: { title: string; body: string }) {
  if (!body) return null;
  return (
    <div>
      <div className="text-xs font-semibold text-gray-500 mb-0.5">{title}</div>
      <p className="text-gray-700">{body}</p>
    </div>
  );
}

function BetterCandidate({ label, quote }: { label: string; quote: string }) {
  return (
    <div className="bg-amber-50 border border-amber-200 rounded-md p-2 text-xs">
      <div className="font-semibold text-amber-800 mb-1">💡 {label}</div>
      <p className="text-gray-700 italic">"{quote}"</p>
    </div>
  );
}
