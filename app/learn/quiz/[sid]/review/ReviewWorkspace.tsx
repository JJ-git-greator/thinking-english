"use client";

import { useState, useMemo } from "react";
import Link from "next/link";
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
  is_correct: boolean | null;
  remediation_text: string | null;
  prompt: string;
  choices: Choice[];
  correct_answer: string;
  explanation: string;
  passage: { title: string; body: string } | null;
}

interface Props {
  sessionId: string;
  sessionTopic: string;
  initialRemediationDone: boolean;
  /** DB에 remediation_text 컬럼이 있을 때만 오답 교정 입력을 띄운다 */
  remediationAvailable?: boolean;
  /** 한 지문에서만 나온 묶음이면 그 지문 */
  passage?: { id: string; title: string } | null;
  attempts: AttemptItem[];
}

export default function ReviewWorkspace({
  sessionId,
  sessionTopic,
  initialRemediationDone,
  remediationAvailable = true,
  passage = null,
  attempts: initial,
}: Props) {
  const supabase = createClient();
  const [attempts, setAttempts] = useState<AttemptItem[]>(initial);
  const [remediationDone, setRemediationDone] = useState(initialRemediationDone);
  const [saving, setSaving] = useState<string | null>(null);

  const wrongs = useMemo(() => attempts.filter((a) => a.is_correct === false), [attempts]);
  const wrongsRemaining = useMemo(
    () =>
      remediationAvailable
        ? wrongs.filter((a) => !a.remediation_text || a.remediation_text.trim().length < 4)
        : [],
    [wrongs, remediationAvailable],
  );

  async function saveRemediation(attemptId: string, text: string) {
    setSaving(attemptId);
    const { error } = await supabase
      .from("te_question_attempts")
      .update({ remediation_text: text.trim() })
      .eq("id", attemptId);
    setSaving(null);
    if (error) {
      alert("저장 실패: " + error.message);
      return;
    }
    setAttempts((prev) =>
      prev.map((a) => (a.id === attemptId ? { ...a, remediation_text: text.trim() } : a)),
    );
  }

  async function finishRemediation() {
    if (wrongsRemaining.length > 0) return;
    setSaving("finish");
    const { error } = await supabase
      .from("te_quiz_sessions")
      .update({ remediation_done: true })
      .eq("id", sessionId);
    setSaving(null);
    if (error) {
      alert("저장 실패: " + error.message);
      return;
    }
    setRemediationDone(true);
  }

  return (
    <div className="space-y-6">
      {!remediationDone && remediationAvailable && wrongs.length > 0 && (
        <div className="bg-amber-50 border border-amber-200 rounded-lg p-4 text-sm text-amber-900">
          오답 <b>{wrongs.length}개</b> 중 <b>{wrongs.length - wrongsRemaining.length}개</b>{" "}
          교정 완료. 나머지 <b>{wrongsRemaining.length}개</b>도 한 줄 적어주세요.
        </div>
      )}

      {attempts.map((a) => (
        <AttemptCard
          key={a.id}
          attempt={a}
          remediationAvailable={remediationAvailable}
          onSaveRemediation={(text) => saveRemediation(a.id, text)}
          saving={saving === a.id}
        />
      ))}

      <div className="bg-white border rounded-lg p-5 space-y-3">
        {remediationDone || !remediationAvailable ? (
          <div className="space-y-3">
            <p className="text-sm text-gray-700">
              {passage
                ? "이 지문은 여기까지예요. 새 지문으로 넘어가거나, 같은 지문을 한 번 더 풀어도 좋아요."
                : "정리가 끝났습니다. 한 묶음 더 풀면 같은 유형에서 덜 틀리게 됩니다."}
            </p>
            <div className="flex gap-2 flex-wrap">
              {passage ? (
                <>
                  <Link
                    href={`/learn/passages/${passage.id}`}
                    className="px-4 py-2 rounded-md border border-gray-300 text-gray-700 hover:bg-gray-50"
                  >
                    이 지문 화면으로
                  </Link>
                  <Link
                    href="/learn/passages"
                    className="px-4 py-2 rounded-md bg-brand-600 text-white hover:bg-brand-700"
                  >
                    새 지문 고르기 →
                  </Link>
                </>
              ) : (
                <>
                  <Link
                    href="/learn/quiz"
                    className="px-4 py-2 rounded-md border border-gray-300 text-gray-700 hover:bg-gray-50"
                  >
                    카테고리로
                  </Link>
                  <form action="/api/quiz/start" method="post" className="inline">
                    <input type="hidden" name="topic" value={sessionTopic} />
                    <button
                      type="submit"
                      className="px-4 py-2 rounded-md bg-brand-600 text-white hover:bg-brand-700"
                    >
                      같은 카테고리 한 묶음 더 →
                    </button>
                  </form>
                </>
              )}
            </div>
          </div>
        ) : (
          <button
            onClick={finishRemediation}
            disabled={wrongsRemaining.length > 0 || saving === "finish"}
            className="w-full py-3 rounded-md bg-brand-600 text-white font-semibold hover:bg-brand-700 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {wrongsRemaining.length > 0
              ? `오답 ${wrongsRemaining.length}개 교정 남음`
              : saving === "finish"
                ? "처리 중..."
                : "교정 완료 → 다음 10문제 풀기 가능"}
          </button>
        )}
      </div>
    </div>
  );
}

function AttemptCard({
  attempt,
  remediationAvailable,
  onSaveRemediation,
  saving,
}: {
  attempt: AttemptItem;
  remediationAvailable: boolean;
  onSaveRemediation: (text: string) => void;
  saving: boolean;
}) {
  const [text, setText] = useState(attempt.remediation_text ?? "");
  const correct = attempt.is_correct === true;
  return (
    <div
      className={`bg-white border rounded-lg p-5 space-y-3 ${
        correct ? "border-green-200" : "border-red-200"
      }`}
    >
      <div className="flex items-start justify-between">
        <div className="text-sm text-gray-500">
          문제 {attempt.ord}
          <span
            className={`ml-2 inline-block px-2 py-0.5 rounded-full text-xs font-semibold ${
              correct
                ? "bg-green-100 text-green-800"
                : "bg-red-100 text-red-800"
            }`}
          >
            {correct ? "정답" : "오답"}
          </span>
        </div>
      </div>

      {attempt.passage && (
        <details className="bg-gray-50 border border-gray-200 rounded-md p-3 text-sm">
          <summary className="cursor-pointer font-medium text-gray-700">
            참고 지문 — {attempt.passage.title}
          </summary>
          <p className="mt-2 text-gray-700 leading-relaxed whitespace-pre-wrap">
            {attempt.passage.body}
          </p>
        </details>
      )}

      <p className="text-gray-800 whitespace-pre-wrap">{attempt.prompt}</p>

      <ul className="space-y-1">
        {attempt.choices.map((c) => {
          const isChosen = attempt.chosen_answer === c.key;
          const isCorrect = attempt.correct_answer === c.key;
          let cls = "border-gray-200";
          if (isCorrect) cls = "border-green-400 bg-green-50";
          else if (isChosen) cls = "border-red-400 bg-red-50";
          return (
            <li
              key={c.key}
              className={`border rounded-md px-3 py-2 text-sm ${cls}`}
            >
              <span className="font-semibold mr-2">{c.key}.</span>
              {c.text}
              {isChosen && (
                <span className="ml-2 text-xs text-gray-500">[내 선택]</span>
              )}
              {isCorrect && (
                <span className="ml-2 text-xs text-green-700">[정답]</span>
              )}
            </li>
          );
        })}
      </ul>

      {attempt.reason_text && (
        <div className="text-xs text-gray-500">
          <span className="font-semibold">내 근거:</span> {attempt.reason_text}
        </div>
      )}

      {attempt.explanation && (
        <div className="text-xs text-gray-600 bg-gray-50 rounded p-2">
          <span className="font-semibold">해설:</span> {attempt.explanation}
        </div>
      )}

      {!correct && remediationAvailable && (
        <div className="space-y-1">
          <label className="block text-sm font-medium text-amber-800">
            왜 틀렸는지 / 무엇을 놓쳤는지 한 줄
          </label>
          <div className="flex gap-2">
            <input
              type="text"
              value={text}
              onChange={(e) => setText(e.target.value)}
              placeholder="예: 단락 마지막 문장을 안 읽고 두 번째 선택지에 끌렸다"
              className="flex-1 px-3 py-2 border rounded-md"
              maxLength={300}
            />
            <button
              onClick={() => onSaveRemediation(text)}
              disabled={text.trim().length < 4 || saving}
              className="px-4 py-2 rounded-md bg-amber-600 text-white font-medium hover:bg-amber-700 disabled:opacity-50"
            >
              {saving ? "저장 중" : "교정 저장"}
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
