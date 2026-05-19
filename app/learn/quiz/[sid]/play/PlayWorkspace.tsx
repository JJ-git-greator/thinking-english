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
}

export default function PlayWorkspace({ sessionId, initialIndex, attempts: initial }: Props) {
  const router = useRouter();
  const supabase = createClient();
  const [attempts, setAttempts] = useState<AttemptItem[]>(initial);
  const [idx, setIdx] = useState(initialIndex);
  const current = attempts[idx];

  const [chosen, setChosen] = useState<string>(current?.chosen_answer ?? "");
  const [reason, setReason] = useState<string>(current?.reason_text ?? "");
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const isLast = idx === attempts.length - 1;
  const total = attempts.length;
  const answered = attempts.filter((a) => !!a.chosen_answer).length;

  function loadFromAttempt(i: number) {
    const a = attempts[i];
    setChosen(a.chosen_answer ?? "");
    setReason(a.reason_text ?? "");
    setError(null);
  }

  async function handleSaveNext() {
    if (!chosen) {
      setError("답을 선택해 주세요.");
      return;
    }
    if (!reason.trim() || reason.trim().length < 4) {
      setError("근거를 한 줄(4자 이상) 적어주세요. 왜 그 답을 골랐는지 짧게라도.");
      return;
    }
    setError(null);
    setSaving(true);

    // Save current attempt
    const { error: upErr } = await supabase
      .from("te_question_attempts")
      .update({
        chosen_answer: chosen,
        reason_text: reason.trim(),
        answered_at: new Date().toISOString(),
      })
      .eq("id", current.id);

    if (upErr) {
      setError(upErr.message);
      setSaving(false);
      return;
    }

    const nextAttempts = attempts.map((a, i) =>
      i === idx ? { ...a, chosen_answer: chosen, reason_text: reason.trim() } : a,
    );
    setAttempts(nextAttempts);

    if (isLast) {
      // All 10 answered → trigger grading via API
      const resp = await fetch(`/api/quiz/${sessionId}/grade`, { method: "POST" });
      if (!resp.ok) {
        const data = await resp.json().catch(() => ({}));
        setError(data?.message ?? "채점 실패");
        setSaving(false);
        return;
      }
      router.push(`/learn/quiz/${sessionId}/review`);
      return;
    }

    setIdx(idx + 1);
    loadFromAttempt(idx + 1);
    setSaving(false);
  }

  function handleJump(targetIdx: number) {
    setIdx(targetIdx);
    loadFromAttempt(targetIdx);
  }

  if (!current) return null;
  const choices: Choice[] = Array.isArray(current.question.choices)
    ? current.question.choices
    : [];

  return (
    <div className="space-y-5">
      {/* Number bar */}
      <div className="flex flex-wrap gap-1">
        {attempts.map((a, i) => (
          <button
            key={a.id}
            onClick={() => handleJump(i)}
            className={`w-8 h-8 rounded text-sm font-medium border ${
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
      </div>

      {current.question.passage && (
        <div className="bg-amber-50 border border-amber-200 rounded-lg p-5 space-y-2">
          <div className="text-xs font-semibold text-amber-700">
            참고 지문 — {current.question.passage.title}
          </div>
          <p className="text-gray-800 leading-relaxed whitespace-pre-wrap">
            {current.question.passage.body}
          </p>
        </div>
      )}

      <div className="bg-white border rounded-lg p-6 space-y-4">
        <div className="text-sm text-gray-500">문제 {current.ord} / {total}</div>
        <p className="text-lg leading-relaxed text-gray-900 whitespace-pre-wrap">
          {current.question.prompt}
        </p>

        <div className="space-y-2">
          {choices.map((c) => (
            <label
              key={c.key}
              className={`flex items-start gap-3 border rounded-md p-3 cursor-pointer transition ${
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
            근거 (왜 이 답을 골랐는지 한 줄)
          </label>
          <input
            type="text"
            value={reason}
            onChange={(e) => setReason(e.target.value)}
            placeholder="예: 단락의 마지막 문장이 ~라고 말하니까"
            className="w-full px-3 py-2 border rounded-md"
            maxLength={300}
          />
          <p className="text-xs text-gray-400 mt-1">
            짧아도 됩니다. 본문 어디를 보고 골랐는지만 적어주세요.
          </p>
        </div>

        {error && (
          <div className="text-sm text-red-600 bg-red-50 border border-red-200 rounded-md p-2">
            {error}
          </div>
        )}

        <button
          onClick={handleSaveNext}
          disabled={saving}
          className="w-full py-3 rounded-md bg-brand-600 text-white font-semibold hover:bg-brand-700 disabled:opacity-50"
        >
          {saving ? "저장 중..." : isLast ? "10문제 끝, 채점 받기" : "다음 문제로"}
        </button>
      </div>

      <div className="text-xs text-gray-400 text-center">
        한 문제 풀 때마다 자동 저장됩니다. 중간에 닫고 와도 이어풀 수 있어요.
      </div>
    </div>
  );
}
