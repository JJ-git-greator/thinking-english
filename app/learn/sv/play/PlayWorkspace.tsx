"use client";

import { useState, useEffect, useRef } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/client";

interface Item {
  id: string;
  full_sentence: string;
  tokens: string[];
  subject_start: number;
  subject_end: number;
  verb_start: number;
  verb_end: number;
  kind: "subject" | "verb";
}

interface Props {
  items: Item[];
  /** 단락 학습 흐름 안에서 열렸을 때, 다음 단계로 바로 보내기 */
  nextHref?: string | null;
  nextLabel?: string | null;
}

interface Result {
  itemId: string;
  kind: "subject" | "verb";
  correct: boolean;
  elapsedMs: number;
}

export default function PlayWorkspace({ items, nextHref = null, nextLabel = null }: Props) {
  const router = useRouter();
  const supabase = createClient();
  const [idx, setIdx] = useState(0);
  const [results, setResults] = useState<Result[]>([]);
  const [chosenIdx, setChosenIdx] = useState<number | null>(null);
  const [revealed, setRevealed] = useState(false);
  const startedAtRef = useRef<number>(Date.now());

  // 새 문항 진입 시 타이머 리셋
  useEffect(() => {
    startedAtRef.current = Date.now();
    setChosenIdx(null);
    setRevealed(false);
  }, [idx]);

  if (items.length === 0) return null;

  const finished = idx >= items.length;

  if (finished) {
    const total = results.length;
    const correct = results.filter((r) => r.correct).length;
    const avgMs =
      total > 0 ? Math.round(results.reduce((a, r) => a + r.elapsedMs, 0) / total) : 0;
    const pct = total > 0 ? Math.round((correct / total) * 100) : 0;

    return (
      <div className="space-y-6">
        <div className="bg-gradient-to-br from-orange-500 to-amber-500 text-white rounded-2xl p-6 sm:p-8 text-center shadow-md">
          <div className="text-5xl mb-2">{pct >= 80 ? "🎉" : pct >= 50 ? "👍" : "💪"}</div>
          <div className="text-orange-50 text-sm font-semibold mb-1">세트 완료</div>
          <div className="text-4xl font-bold mb-1">
            {correct} / {total}
          </div>
          <div className="text-orange-50">
            정답률 <b className="text-white">{pct}%</b> · 평균{" "}
            <b className="text-white">{(avgMs / 1000).toFixed(1)}초</b>/문항
          </div>
        </div>
        <div className="grid sm:grid-cols-2 gap-3">
          <button
            onClick={() => router.refresh()}
            className="px-5 py-3 rounded-lg border-2 border-gray-200 bg-white text-gray-700 font-semibold hover:bg-gray-50 active:scale-[0.99] transition"
          >
            ↺ 다시 하기
          </button>
          {nextHref ? (
            <Link
              href={nextHref}
              className="text-center px-5 py-3 rounded-lg bg-brand-600 text-white font-bold hover:bg-brand-700 active:scale-[0.99] transition"
            >
              다음: {nextLabel} →
            </Link>
          ) : (
            <Link
              href="/learn/sv"
              className="text-center px-5 py-3 rounded-lg bg-gray-100 text-gray-800 font-semibold hover:bg-gray-200 active:scale-[0.99] transition"
            >
              메뉴로 돌아가기
            </Link>
          )}
        </div>
      </div>
    );
  }

  const item = items[idx];
  const correctStart = item.kind === "subject" ? item.subject_start : item.verb_start;
  const correctEnd = item.kind === "subject" ? item.subject_end : item.verb_end;

  function isCorrectClick(i: number) {
    return i >= correctStart && i <= correctEnd;
  }

  async function handleClick(i: number) {
    if (revealed) return;
    const elapsed = Date.now() - startedAtRef.current;
    const correct = isCorrectClick(i);
    setChosenIdx(i);
    setRevealed(true);

    // DB 기록 (실패해도 진행)
    const { data: userResp } = await supabase.auth.getUser();
    if (userResp.user) {
      supabase
        .from("te_sv_drill_attempts")
        .insert({
          user_id: userResp.user.id,
          sentence_id: item.id,
          kind: item.kind,
          is_correct: correct,
          elapsed_ms: elapsed,
        })
        .then(() => {});
    }

    setResults((prev) => [...prev, { itemId: item.id, kind: item.kind, correct, elapsedMs: elapsed }]);
  }

  function goNext() {
    setIdx(idx + 1);
  }

  const kindLabel = item.kind === "subject" ? "주어" : "동사";
  const kindColor = item.kind === "subject" ? "amber" : "sky";

  return (
    <div className="space-y-5">
      {/* 진척 바 */}
      <div className="bg-gray-50 border rounded-lg px-4 py-3 flex items-center justify-between">
        <div className="text-sm text-gray-700">
          <b>{idx + 1}</b> / {items.length}
        </div>
        <div className="flex gap-1">
          {items.map((_, i) => {
            const r = results[i];
            return (
              <span
                key={i}
                className={`block w-5 h-1.5 rounded-full ${
                  i === idx
                    ? "bg-orange-500"
                    : r?.correct
                      ? "bg-emerald-400"
                      : r
                        ? "bg-red-400"
                        : "bg-gray-200"
                }`}
              />
            );
          })}
        </div>
      </div>

      {/* 질문 */}
      <div
        className={`rounded-xl px-5 py-4 text-center text-base sm:text-lg font-bold ${
          kindColor === "amber"
            ? "bg-amber-50 border-2 border-amber-300 text-amber-900"
            : "bg-sky-50 border-2 border-sky-300 text-sky-900"
        }`}
      >
        문장 안에서 <span className="text-2xl">{kindLabel}</span>를 클릭하세요
      </div>

      {/* 문장 토큰 — 클릭 가능 */}
      <div className="bg-white border-2 border-gray-200 rounded-xl p-5 sm:p-6">
        <div className="flex flex-wrap gap-1.5 leading-relaxed">
          {item.tokens.map((tok, i) => {
            const isCorrectWord = isCorrectClick(i);
            const isChosen = chosenIdx === i;
            const chosenCorrect = chosenIdx != null && isCorrectClick(chosenIdx);

            let cls =
              "px-2 py-1 rounded-md transition select-none text-base sm:text-lg font-medium";

            if (!revealed) {
              cls += " bg-gray-50 hover:bg-gray-200 cursor-pointer active:scale-95";
            } else {
              // 공개 후: 정답 자리 + 학생 선택 강조
              if (isCorrectWord) {
                cls += " bg-emerald-200 text-emerald-900 ring-2 ring-emerald-500";
              } else if (isChosen) {
                cls += " bg-red-200 text-red-900 ring-2 ring-red-500";
              } else {
                cls += " bg-gray-50 text-gray-500";
              }
            }

            return (
              <button
                key={i}
                type="button"
                disabled={revealed}
                onClick={() => handleClick(i)}
                className={cls}
              >
                {tok}
              </button>
            );
          })}
        </div>

        {/* 피드백 */}
        {revealed && (
          <div className="mt-5 pt-4 border-t flex items-center justify-between gap-3 flex-wrap">
            <div>
              {chosenIdx != null && isCorrectClick(chosenIdx) ? (
                <div className="text-emerald-700 font-bold text-lg">✓ 정답</div>
              ) : (
                <div className="text-red-600 font-bold text-lg">
                  ✗ 오답 · 초록색이 정답 자리
                </div>
              )}
            </div>
            <button
              onClick={goNext}
              className="px-5 py-2.5 rounded-lg bg-orange-600 text-white font-semibold hover:bg-orange-700 active:scale-[0.99] transition"
            >
              {idx + 1 === items.length ? "결과 보기 →" : "다음 문장 →"}
            </button>
          </div>
        )}
      </div>
    </div>
  );
}
