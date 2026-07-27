"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";

interface Choice {
  key: string;
  text: string;
}

interface AttemptItem {
  id: string;
  ord: number;
  chosen_answer: string | null;
  reason_text: string | null;
  question: {
    prompt: string;
    choices: Choice[];
    passage: { title: string; body: string } | null;
  };
}

interface Props {
  sessionId: string;
  initialIndex: number;
  attempts: AttemptItem[];
  /** 한 지문에서 나온 묶음이면 지문 제목 */
  singlePassageTitle?: string | null;
}

export default function PlayWorkspace({
  sessionId,
  initialIndex,
  attempts: initial,
  singlePassageTitle,
}: Props) {
  const router = useRouter();
  const supabase = createClient();
  const [attempts, setAttempts] = useState<AttemptItem[]>(initial);
  const [idx, setIdx] = useState(initialIndex);
  const current = attempts[idx];

  const [chosen, setChosen] = useState<string>(current?.chosen_answer ?? "");
  const [reason, setReason] = useState<string>(current?.reason_text ?? "");
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [grading, setGrading] = useState(false);

  const isLast = idx === attempts.length - 1;
  const isFirst = idx === 0;
  const total = attempts.length;
  const answeredCount = attempts.filter((a) => !!a.chosen_answer).length;
  const unanswered = attempts.filter((a) => !a.chosen_answer);
  const allAnswered = unanswered.length === 0;

  function loadFromAttempt(i: number, source?: AttemptItem[]) {
    const a = (source ?? attempts)[i];
    setChosen(a.chosen_answer ?? "");
    setReason(a.reason_text ?? "");
    setError(null);
  }

  /** 현재 문제 저장 (답을 안 골랐으면 저장할 게 없으므로 그냥 통과) */
  async function persistCurrent(): Promise<AttemptItem[]> {
    if (!chosen) return attempts;
    const alreadySame =
      current.chosen_answer === chosen && (current.reason_text ?? "") === reason.trim();
    const nextAttempts = attempts.map((a, i) =>
      i === idx ? { ...a, chosen_answer: chosen, reason_text: reason.trim() || null } : a,
    );
    setAttempts(nextAttempts);
    if (alreadySame) return nextAttempts;

    setSaving(true);
    const { error: upErr } = await supabase
      .from("te_question_attempts")
      .update({
        chosen_answer: chosen,
        reason_text: reason.trim() || null,
        answered_at: new Date().toISOString(),
      })
      .eq("id", current.id);
    setSaving(false);
    if (upErr) setError("저장에 실패했어요: " + upErr.message);
    return nextAttempts;
  }

  async function goTo(targetIdx: number) {
    const next = await persistCurrent();
    setIdx(targetIdx);
    loadFromAttempt(targetIdx, next);
  }

  async function handleGrade() {
    const next = await persistCurrent();
    const stillMissing = next.filter((a) => !a.chosen_answer);
    if (stillMissing.length > 0) {
      setError(
        `아직 안 푼 문제가 ${stillMissing.length}개 있어요 (${stillMissing
          .map((a) => a.ord)
          .join(", ")}번). 위 번호를 눌러 채워주세요.`,
      );
      return;
    }
    setGrading(true);
    const resp = await fetch(`/api/quiz/${sessionId}/grade`, { method: "POST" });
    if (!resp.ok) {
      const data = await resp.json().catch(() => ({}));
      setError(data?.message ?? "채점에 실패했어요.");
      setGrading(false);
      return;
    }
    router.push(`/learn/quiz/${sessionId}/review`);
  }

  if (!current) return null;
  const choices: Choice[] = Array.isArray(current.question.choices)
    ? current.question.choices
    : [];

  return (
    <div className="space-y-5">
      {/* 번호 바 */}
      <div className="flex flex-wrap gap-1">
        {attempts.map((a, i) => (
          <button
            key={a.id}
            onClick={() => goTo(i)}
            className={`w-8 h-8 rounded text-sm font-medium border transition active:scale-95 ${
              i === idx
                ? "bg-brand-600 text-white border-brand-600"
                : a.chosen_answer
                  ? "bg-brand-100 text-brand-700 border-brand-200"
                  : "bg-white text-gray-500 border-gray-200"
            }`}
            title={a.chosen_answer ? `답: ${a.chosen_answer}` : "미응답"}
          >
            {a.ord}
          </button>
        ))}
        <span className="ml-auto text-xs text-gray-500 self-center">
          {answeredCount} / {total} 완료
        </span>
      </div>

      {current.question.passage && (
        <details
          open
          className="bg-amber-50 border border-amber-200 rounded-lg p-4 sm:p-5"
        >
          <summary className="text-xs font-semibold text-amber-800 cursor-pointer select-none">
            {singlePassageTitle
              ? `읽은 지문 — ${current.question.passage.title} (접으려면 탭)`
              : `참고 지문 — ${current.question.passage.title} (접으려면 탭)`}
          </summary>
          <p className="text-gray-800 leading-relaxed whitespace-pre-wrap mt-2">
            {current.question.passage.body}
          </p>
        </details>
      )}

      <div className="bg-white border rounded-lg p-5 sm:p-6 space-y-4">
        <div className="text-sm text-gray-500">
          문제 {current.ord} / {total}
        </div>
        <p className="text-lg leading-relaxed text-gray-900 whitespace-pre-wrap">
          {current.question.prompt}
        </p>

        <div className="space-y-2">
          {choices.map((c) => (
            <label
              key={c.key}
              className={`flex items-start gap-3 border-2 rounded-md p-3 cursor-pointer transition ${
                chosen === c.key
                  ? "border-brand-600 bg-brand-50"
                  : "border-gray-200 hover:bg-gray-50"
              }`}
            >
              <input
                type="radio"
                name="answer"
                value={c.key}
                checked={chosen === c.key}
                onChange={(e) => setChosen(e.target.value)}
                className="mt-1"
              />
              <div>
                <span className="font-semibold mr-2">{c.key}.</span>
                <span>{c.text}</span>
              </div>
            </label>
          ))}
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            왜 이 답을 골랐나요? <span className="text-gray-400 text-xs">(안 적어도 넘어가요)</span>
          </label>
          <input
            type="text"
            value={reason}
            onChange={(e) => setReason(e.target.value)}
            placeholder="예: 마지막 문장이 ~라고 말해서"
            className="w-full px-3 py-2 border rounded-md"
            maxLength={300}
          />
        </div>

        {error && (
          <div className="text-sm text-red-600 bg-red-50 border border-red-200 rounded-md p-2">
            {error}
          </div>
        )}

        {/* 이전 / 다음 — 답을 안 골라도 자유롭게 이동 */}
        <div className="grid grid-cols-2 gap-3">
          <button
            onClick={() => goTo(idx - 1)}
            disabled={isFirst || saving}
            className="py-3 rounded-lg border-2 border-gray-200 text-gray-700 font-semibold hover:bg-gray-50 disabled:opacity-40 active:scale-[0.99] transition"
          >
            ← 이전 문제
          </button>
          {isLast ? (
            <button
              onClick={handleGrade}
              disabled={grading || saving}
              className="py-3 rounded-lg bg-accent-600 text-white font-semibold hover:bg-accent-500 disabled:opacity-50 active:scale-[0.99] transition"
            >
              {grading ? "채점 중..." : allAnswered || chosen ? "채점 받기 →" : "채점 받기"}
            </button>
          ) : (
            <button
              onClick={() => goTo(idx + 1)}
              disabled={saving}
              className="py-3 rounded-lg bg-brand-600 text-white font-semibold hover:bg-brand-700 disabled:opacity-50 active:scale-[0.99] transition"
            >
              다음 문제 →
            </button>
          )}
        </div>

        {!isLast && allAnswered && (
          <button
            onClick={handleGrade}
            disabled={grading || saving}
            className="w-full py-2.5 rounded-lg border-2 border-accent-600 text-accent-600 font-semibold hover:bg-blue-50 disabled:opacity-50"
          >
            {grading ? "채점 중..." : "다 풀었어요 · 지금 채점 받기"}
          </button>
        )}
      </div>

      <div className="text-xs text-gray-400 text-center">
        답을 고르면 자동 저장됩니다. 중간에 닫고 와도 이어풀 수 있어요.
      </div>
    </div>
  );
}
