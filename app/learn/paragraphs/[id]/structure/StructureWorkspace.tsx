"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";

interface Choice {
  key: string;
  text: string;
}

interface Question {
  id: string;
  ord: number;
  kind: string; // 'subject' | 'verb' | 'structure'
  prompt: string;
  target_sentence: string | null;
  choices: Choice[];
  correct_answer: string;
  explanation: string | null;
  last: { chosen_answer: string; is_correct: boolean } | null;
}

interface Props {
  paragraphId: string;
  paragraphBody: string;
  passageId: string;
  questions: Question[];
  nextHref: string;
  nextLabel: string;
}

const KIND_LABEL: Record<string, string> = {
  subject: "주어 찾기",
  verb: "동사 일치",
  structure: "문장 구조",
};

const KIND_COLOR: Record<string, string> = {
  subject: "bg-amber-100 text-amber-800",
  verb: "bg-sky-100 text-sky-800",
  structure: "bg-indigo-100 text-indigo-800",
};

export default function StructureWorkspace({
  paragraphId,
  paragraphBody,
  passageId,
  questions: initial,
  nextHref,
  nextLabel,
}: Props) {
  const router = useRouter();
  const supabase = createClient();
  const [questions, setQuestions] = useState(initial);

  if (initial.length === 0) {
    return (
      <div className="bg-amber-50 border border-amber-200 rounded-xl p-6 text-center space-y-2">
        <div className="text-4xl">📝</div>
        <p className="text-gray-700 font-semibold">아직 이 단락의 구조 문제가 준비되지 않았어요.</p>
        <p className="text-sm text-gray-500">
          선생님이 추가하면 여기에 객관식이 표시됩니다. 일단 다음 단계로 넘어가도 괜찮아요.
        </p>
        <button
          onClick={() => router.push(nextHref)}
          className="mt-3 px-4 py-2 rounded-md bg-blue-600 text-white text-sm font-semibold hover:bg-blue-700"
        >
          {nextLabel} →
        </button>
      </div>
    );
  }

  const correctCount = questions.filter((q) => q.last?.is_correct).length;
  const answeredCount = questions.filter((q) => !!q.last).length;
  const allAnswered = answeredCount === questions.length;

  return (
    <div className="space-y-5">
      {/* 단락 본문 (참고용) */}
      <div className="bg-white border rounded-xl p-5 sm:p-6">
        <div className="text-xs font-semibold text-gray-500 mb-2">참고 단락</div>
        <p className="text-gray-800 leading-relaxed whitespace-pre-wrap">{paragraphBody}</p>
      </div>

      {/* 진척 */}
      <div className="flex items-center justify-between bg-gray-50 border rounded-lg px-4 py-3">
        <div className="text-sm text-gray-700">
          진행: <b>{answeredCount}</b> / {questions.length}
        </div>
        {allAnswered && (
          <div className="text-sm">
            정답: <b className="text-green-700">{correctCount}</b> / {questions.length}
          </div>
        )}
      </div>

      {/* 문제 목록 */}
      <div className="space-y-3">
        {questions.map((q) => (
          <QuestionCard
            key={q.id}
            question={q}
            onAnswered={(chosenAnswer, isCorrect) => {
              setQuestions((prev) => {
                const next = prev.map((x) =>
                  x.id === q.id
                    ? { ...x, last: { chosen_answer: chosenAnswer, is_correct: isCorrect } }
                    : x,
                );
                // 이 단락 구조 문제를 다 풀면 진척(2회독 완료)을 기록한다
                if (next.every((x) => !!x.last)) void markStructureDone(supabase, paragraphId);
                return next;
              });
            }}
            supabase={supabase}
            paragraphId={paragraphId}
          />
        ))}
      </div>

      {/* 끝나면 다음으로 */}
      {allAnswered && (
        <div className="bg-gradient-to-r from-sky-50 to-blue-50 border border-sky-200 rounded-xl p-5 sm:p-6 space-y-3">
          <div className="text-sm text-sky-700 font-semibold">문장 구조 점검 완료 🎉</div>
          <p className="text-gray-700">
            {correctCount === questions.length
              ? "모두 맞췄어요! 단락 구조가 머릿속에 잘 박혔어요."
              : `${questions.length}문제 중 ${correctCount}개 맞췄어요. 틀린 문제는 해설을 다시 한 번 보고 가세요.`}
          </p>
          <button
            onClick={() => router.push(nextHref)}
            className="px-5 py-2.5 rounded-lg bg-blue-600 text-white font-semibold hover:bg-blue-700"
          >
            다음: {nextLabel} →
          </button>
        </div>
      )}
    </div>
  );
}

/** 단락 구조 문제를 모두 풀면 te_gist_notes.structure_done_at 을 찍어 진척에 반영 */
async function markStructureDone(
  supabase: ReturnType<typeof createClient>,
  paragraphId: string,
) {
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) return;
  await supabase
    .from("te_gist_notes")
    .update({ structure_done_at: new Date().toISOString() })
    .eq("user_id", userResp.user.id)
    .eq("paragraph_id", paragraphId)
    .is("structure_done_at", null);
}

function QuestionCard({
  question: q,
  onAnswered,
  supabase,
  paragraphId,
}: {
  question: Question;
  onAnswered: (chosenAnswer: string, isCorrect: boolean) => void;
  supabase: ReturnType<typeof createClient>;
  paragraphId: string;
}) {
  const [chosen, setChosen] = useState<string | null>(q.last?.chosen_answer ?? null);
  const [revealed, setRevealed] = useState(!!q.last);
  const [saving, setSaving] = useState(false);

  async function handleChoose(key: string) {
    if (revealed || saving) return;
    setChosen(key);
    setSaving(true);

    const isCorrect = key === q.correct_answer;
    const { data: userResp } = await supabase.auth.getUser();
    if (userResp.user) {
      await supabase.from("te_structure_attempts").insert({
        user_id: userResp.user.id,
        question_id: q.id,
        paragraph_id: paragraphId,
        chosen_answer: key,
        is_correct: isCorrect,
      });
    }
    setRevealed(true);
    setSaving(false);
    onAnswered(key, isCorrect);
  }

  const wasCorrect = q.last?.is_correct ?? null;

  return (
    <div
      className={`bg-white border-2 rounded-xl p-5 sm:p-6 transition ${
        revealed
          ? wasCorrect
            ? "border-green-300"
            : "border-red-300"
          : "border-gray-200"
      }`}
    >
      {/* 헤더 */}
      <div className="flex items-center gap-2 mb-2">
        <span className="text-xs font-bold text-gray-400">문제 {q.ord + 1}</span>
        <span className={`text-xs px-2 py-0.5 rounded-full font-semibold ${KIND_COLOR[q.kind] ?? "bg-gray-100 text-gray-700"}`}>
          {KIND_LABEL[q.kind] ?? q.kind}
        </span>
        {revealed && (
          <span
            className={`text-xs px-2 py-0.5 rounded-full font-bold ${
              wasCorrect ? "bg-green-500 text-white" : "bg-red-500 text-white"
            }`}
          >
            {wasCorrect ? "✓ 정답" : "✗ 오답"}
          </span>
        )}
      </div>

      {/* 질문 */}
      <p className="text-gray-900 font-semibold mb-2 leading-relaxed">{q.prompt}</p>

      {/* 대상 영어 문장 */}
      {q.target_sentence && (
        <div className="bg-gray-50 border-l-4 border-sky-400 px-3 py-2 mb-3 text-sm italic text-gray-700 rounded">
          "{q.target_sentence}"
        </div>
      )}

      {/* 보기 */}
      <div className="space-y-2">
        {q.choices.map((c) => {
          const isChosen = chosen === c.key;
          const isCorrectChoice = c.key === q.correct_answer;
          let cls = "border-gray-200 hover:bg-gray-50 cursor-pointer";
          if (revealed) {
            if (isCorrectChoice) cls = "border-green-400 bg-green-50";
            else if (isChosen) cls = "border-red-400 bg-red-50";
            else cls = "border-gray-200 opacity-60";
          } else if (isChosen) {
            cls = "border-brand-500 bg-brand-50";
          }
          return (
            <button
              key={c.key}
              type="button"
              disabled={revealed || saving}
              onClick={() => handleChoose(c.key)}
              className={`w-full text-left border-2 rounded-lg px-4 py-3 text-sm sm:text-base transition active:scale-[0.99] ${cls}`}
            >
              <span className="font-semibold mr-2">{c.key}.</span>
              {c.text}
              {revealed && isChosen && !isCorrectChoice && (
                <span className="ml-2 text-xs text-red-700">[내 선택]</span>
              )}
              {revealed && isCorrectChoice && (
                <span className="ml-2 text-xs text-green-700">[정답]</span>
              )}
            </button>
          );
        })}
      </div>

      {/* 해설 */}
      {revealed && q.explanation && (
        <div className="mt-4 bg-blue-50 border border-blue-200 rounded-md p-3 text-sm text-gray-800">
          <div className="font-semibold text-blue-800 mb-1">해설</div>
          {q.explanation}
        </div>
      )}
    </div>
  );
}
