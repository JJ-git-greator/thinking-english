"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";

interface Chunk {
  en: string;
  ko: string;
}

interface Sentence {
  id: string;
  ord: number;
  full_sentence: string;
  chunks: Chunk[];
  note: string | null;
}

interface Props {
  paragraphId: string;
  paragraphBody: string;
  passageId: string;
  passageTitle: string;
  sentences: Sentence[];
}

const RATING_LABEL: Record<number, string> = {
  3: "익숙",
  2: "보통",
  1: "다시",
};
const RATING_COLOR: Record<number, string> = {
  3: "bg-green-500 hover:bg-green-600 text-white",
  2: "bg-amber-500 hover:bg-amber-600 text-white",
  1: "bg-red-500 hover:bg-red-600 text-white",
};

export default function ChunkWorkspace({
  paragraphId,
  paragraphBody,
  passageId,
  passageTitle,
  sentences,
}: Props) {
  const router = useRouter();
  const supabase = createClient();
  const [idx, setIdx] = useState(0);

  if (sentences.length === 0) {
    return (
      <div className="bg-amber-50 border border-amber-200 rounded-xl p-6 text-center space-y-2">
        <div className="text-4xl">📝</div>
        <p className="text-gray-700 font-semibold">아직 이 단락의 직독직해 문장이 준비되지 않았어요.</p>
        <p className="text-sm text-gray-500">강사가 문장을 추가하면 여기서 훈련할 수 있어요.</p>
        <button
          onClick={() => router.back()}
          className="mt-3 px-4 py-2 rounded-md bg-blue-600 text-white text-sm font-semibold hover:bg-blue-700"
        >
          돌아가기
        </button>
      </div>
    );
  }

  const sentence = sentences[idx];
  const isLast = idx === sentences.length - 1;

  function next() {
    if (isLast) {
      router.push(`/learn/passages/${passageId}`);
    } else {
      setIdx(idx + 1);
    }
  }

  return (
    <div className="space-y-4">
      {/* 단락 본문 (참고용, 접힘) */}
      <details className="bg-white border rounded-xl p-4">
        <summary className="text-xs font-semibold text-gray-500 cursor-pointer select-none">
          참고: 단락 전체 보기
        </summary>
        <p className="text-gray-700 leading-relaxed whitespace-pre-wrap mt-2 text-sm">
          {paragraphBody}
        </p>
      </details>

      {/* 진척 표시줄 */}
      <div className="bg-gray-50 border rounded-lg px-4 py-3 flex items-center justify-between">
        <div className="text-sm text-gray-700">
          문장 <b>{idx + 1}</b> / {sentences.length}
        </div>
        <div className="flex gap-1">
          {sentences.map((_, i) => (
            <span
              key={i}
              className={`block w-6 h-1.5 rounded-full ${
                i < idx ? "bg-emerald-400" : i === idx ? "bg-sky-500" : "bg-gray-200"
              }`}
            />
          ))}
        </div>
      </div>

      {/* 트레이너 */}
      <ChunkTrainer
        key={sentence.id}
        sentence={sentence}
        paragraphId={paragraphId}
        supabase={supabase}
        onDone={next}
        isLast={isLast}
      />
    </div>
  );
}

function ChunkTrainer({
  sentence,
  paragraphId,
  supabase,
  onDone,
  isLast,
}: {
  sentence: Sentence;
  paragraphId: string;
  supabase: ReturnType<typeof createClient>;
  onDone: () => void;
  isLast: boolean;
}) {
  const [revealedTo, setRevealedTo] = useState(0); // 0..N (N = 모두 공개)
  const total = sentence.chunks.length;
  const allRevealed = revealedTo >= total;
  const [saving, setSaving] = useState(false);

  function revealNext() {
    if (revealedTo < total) setRevealedTo(revealedTo + 1);
  }

  async function submitRating(rating: 1 | 2 | 3) {
    if (saving) return;
    setSaving(true);
    const { data: userResp } = await supabase.auth.getUser();
    if (userResp.user) {
      await supabase.from("te_chunk_attempts").insert({
        user_id: userResp.user.id,
        sentence_id: sentence.id,
        paragraph_id: paragraphId,
        rating,
      });
    }
    setSaving(false);
    onDone();
  }

  return (
    <div className="bg-white border-2 border-sky-200 rounded-xl p-5 sm:p-6 space-y-4">
      {sentence.note && (
        <div className="text-xs text-sky-700 font-semibold bg-sky-50 inline-block px-2 py-1 rounded">
          💡 {sentence.note}
        </div>
      )}

      {/* 청크 순차 공개 영역 */}
      <ol className="space-y-3">
        {sentence.chunks.map((c, i) => {
          const opened = i < revealedTo;
          const current = i === revealedTo;
          const locked = i > revealedTo;
          return (
            <li
              key={i}
              className={`rounded-lg border-2 px-4 py-3 transition ${
                opened
                  ? "border-emerald-200 bg-emerald-50/60"
                  : current
                  ? "border-sky-300 bg-sky-50"
                  : "border-gray-200 bg-gray-50/50 opacity-60"
              }`}
            >
              <div className="flex items-start gap-3">
                <span
                  className={`text-xs font-bold mt-1 shrink-0 ${
                    opened ? "text-emerald-700" : current ? "text-sky-700" : "text-gray-400"
                  }`}
                >
                  {i + 1}
                </span>
                <div className="flex-1 min-w-0">
                  {locked ? (
                    <div className="text-gray-400 italic select-none">
                      (잠김 — 앞 청크 먼저)
                    </div>
                  ) : (
                    <>
                      <div className="text-gray-900 font-medium leading-relaxed">
                        {c.en}
                      </div>
                      {opened && (
                        <div className="text-sm text-emerald-800 mt-1 leading-relaxed">
                          → {c.ko}
                        </div>
                      )}
                      {current && !opened && (
                        <p className="text-xs text-sky-700 mt-1">
                          이 청크의 한국어 의미를 떠올린 다음 아래 버튼을 누르세요.
                        </p>
                      )}
                    </>
                  )}
                </div>
              </div>
            </li>
          );
        })}
      </ol>

      {/* 액션 */}
      {!allRevealed ? (
        <button
          onClick={revealNext}
          className="w-full px-5 py-3 rounded-lg bg-sky-600 text-white font-semibold hover:bg-sky-700 active:scale-[0.99] transition"
        >
          한국어 의미 확인 →
        </button>
      ) : (
        <div className="space-y-3">
          {/* 전체 문장 다시 보기 */}
          <div className="bg-gray-50 border rounded-lg px-4 py-3">
            <div className="text-xs font-semibold text-gray-500 mb-1">전체 문장</div>
            <p className="text-gray-900 leading-relaxed">{sentence.full_sentence}</p>
          </div>
          <div>
            <div className="text-sm text-gray-700 font-semibold mb-2">
              스스로 평가해주세요
            </div>
            <div className="grid grid-cols-3 gap-2">
              {([3, 2, 1] as const).map((r) => (
                <button
                  key={r}
                  disabled={saving}
                  onClick={() => submitRating(r)}
                  className={`px-3 py-3 rounded-lg font-semibold text-sm transition active:scale-[0.98] disabled:opacity-50 ${RATING_COLOR[r]}`}
                >
                  {RATING_LABEL[r]}
                </button>
              ))}
            </div>
            <p className="text-xs text-gray-500 mt-2">
              {isLast
                ? "마지막 문장입니다. 평가를 누르면 단락 화면으로 돌아갑니다."
                : "평가를 누르면 다음 문장으로 넘어갑니다."}
            </p>
          </div>
        </div>
      )}
    </div>
  );
}
