"use client";

import { useState } from "react";

interface LatestAttempt {
  id: string;
  ai_score: number | null;
  ai_subscores: Record<string, number> | null;
  ai_feedback: {
    strengths?: string[];
    weaknesses?: string[];
    suggestions?: string[];
    rewritten_example?: string;
  } | null;
  student_text: string;
  created_at: string;
}

interface Props {
  paragraphId: string;
  paragraphBody: string;
  gist: { mainIdea: string; supporting: string };
  latest: LatestAttempt | null;
  nextHref: string;
  nextLabel: string;
}

interface GradeResult {
  attemptId: string;
  score: number;
  subscores: { main: number; support: number; flow: number; expression: number };
  strengths: string[];
  weaknesses: string[];
  suggestions: string[];
  rewritten_example: string;
  model: string;
}

export default function ReconstructWorkspace({
  paragraphId,
  paragraphBody,
  gist,
  latest,
  nextHref,
  nextLabel,
}: Props) {
  const [text, setText] = useState(latest?.student_text ?? "");
  const [submitting, setSubmitting] = useState(false);
  const [result, setResult] = useState<GradeResult | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [showOriginal, setShowOriginal] = useState(false);
  const [preferSmart, setPreferSmart] = useState(false);

  async function handleSubmit() {
    if (text.trim().length < 10) {
      setError("최소 10자 이상 작성해 주세요.");
      return;
    }
    setSubmitting(true);
    setError(null);
    setResult(null);

    try {
      const resp = await fetch("/api/grade/reconstruction", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          paragraphId,
          studentText: text.trim(),
          preferSmart,
        }),
      });
      const data = await resp.json();
      if (!resp.ok) {
        throw new Error(data.message || data.error || "첨삭에 실패했어요.");
      }
      setResult(data);
      setShowOriginal(true); // reveal original after grading
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err));
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <div className="space-y-6">
      <div className="bg-brand-50 border border-brand-200 rounded-lg p-5 space-y-2">
        <div className="text-xs font-semibold text-brand-700">메인 아이디어</div>
        <p className="text-gray-800">{gist.mainIdea}</p>
        <div className="text-xs font-semibold text-brand-700 mt-3">서포팅 센텐스</div>
        <p className="text-gray-800">{gist.supporting}</p>
      </div>

      <div className="space-y-2">
        <label className="block text-sm font-medium text-gray-700">
          위 두 문장만 보고, 단락 전체 내용을 <b>한국어로</b> 풀어써 보세요
        </label>
        <textarea
          value={text}
          onChange={(e) => setText(e.target.value)}
          rows={8}
          placeholder="예: 이 단락은 ~한 학습 방식을 설명한다. 먼저 ~한 상황에서 뇌가 어떻게 반응하는지 말하고, 이어서 ~을 예로 든다..."
          className="w-full px-4 py-3 border rounded-lg leading-relaxed"
        />
        <div className="flex items-center justify-between text-sm">
          <span className="text-gray-500">{text.trim().length}자</span>
          <label className="flex items-center gap-2 text-gray-500">
            <input
              type="checkbox"
              checked={preferSmart}
              onChange={(e) => setPreferSmart(e.target.checked)}
            />
            꼼꼼한 첨삭 (시간이 조금 더 걸려요)
          </label>
        </div>
      </div>

      {error && (
        <div className="text-sm text-red-600 bg-red-50 border border-red-200 rounded-md p-3">
          {error}
        </div>
      )}

      <button
        onClick={handleSubmit}
        disabled={submitting}
        className="px-5 py-2.5 rounded-md bg-accent-600 text-white font-semibold hover:bg-accent-500 disabled:opacity-50"
      >
        {submitting ? "첨삭 중..." : "첨삭 받기"}
      </button>

      {/* 채점 후에는 가려뒀던 원문을 피드백보다 먼저 보여준다.
          (원문이 안 보이는 상태로 "마지막 문장을 놓쳤어요" 같은 말을 들으면
           학생은 "그런 문장 없는데?" 하고 혼란스러워한다) */}
      {showOriginal && (
        <div className="bg-white border-2 border-gray-200 rounded-xl p-5">
          <div className="text-sm font-bold text-gray-700 mb-2">
            📖 가려뒀던 원문이에요 — 내가 빠뜨린 부분이 있는지 먼저 확인해 보세요
          </div>
          <p className="text-gray-800 leading-relaxed">{paragraphBody}</p>
        </div>
      )}

      {result && (
        <>
          <ResultPanel result={result} />
          <a
            href={nextHref}
            className="block text-center w-full py-3.5 rounded-xl bg-brand-600 text-white font-bold hover:bg-brand-700 active:scale-[0.99] transition"
          >
            다음: {nextLabel} →
          </a>
        </>
      )}

      {!result && latest && (
        <div className="text-sm text-gray-500">
          최근 점수: {latest.ai_score}점 (
          {new Date(latest.created_at).toLocaleString("ko-KR")})
        </div>
      )}
    </div>
  );
}

function ResultPanel({ result }: { result: GradeResult }) {
  return (
    <div className="space-y-4 bg-white border-2 border-accent-600 rounded-lg p-6">
      <div className="flex items-baseline gap-3">
        <span className="text-5xl font-bold text-accent-600">{result.score}</span>
        <span className="text-gray-500">/ 100</span>
      </div>

      <div className="grid grid-cols-4 gap-3 text-center">
        <SubScore label="핵심 메시지" value={result.subscores.main} max={25} />
        <SubScore label="디테일 반영" value={result.subscores.support} max={25} />
        <SubScore label="논리 흐름" value={result.subscores.flow} max={25} />
        <SubScore label="표현 적절성" value={result.subscores.expression} max={25} />
      </div>

      {result.strengths.length > 0 && (
        <Bullet
          title="잘한 점"
          emoji="👍"
          items={result.strengths.slice(0, 2)}
          box="bg-green-50 border-green-200"
          color="text-green-800"
        />
      )}
      {result.weaknesses.length > 0 && (
        <Bullet
          title="아쉬운 점"
          emoji="🔍"
          items={result.weaknesses.slice(0, 2)}
          box="bg-amber-50 border-amber-200"
          color="text-amber-900"
        />
      )}
      {result.suggestions.length > 0 && (
        <Bullet
          title="다음엔 이렇게"
          emoji="🚀"
          items={result.suggestions.slice(0, 2)}
          box="bg-blue-50 border-blue-200"
          color="text-blue-900"
        />
      )}

      {result.rewritten_example && (
        <details className="bg-gray-50 border rounded-lg p-4">
          <summary className="text-sm font-bold text-gray-700 cursor-pointer select-none">
            📄 이렇게 쓰면 좋아요 (모범 예시 보기)
          </summary>
          <p className="text-gray-700 leading-relaxed mt-2">{result.rewritten_example}</p>
        </details>
      )}

      {/* 엔진 표시는 디버그용이라 노출하지 않음 */}
    </div>
  );
}

function SubScore({ label, value, max }: { label: string; value: number; max: number }) {
  return (
    <div className="bg-gray-50 rounded-md py-2">
      <div className="text-lg font-semibold">
        {value}
        <span className="text-xs text-gray-400">/{max}</span>
      </div>
      <div className="text-xs text-gray-500">{label}</div>
    </div>
  );
}

function Bullet({
  title,
  emoji,
  items,
  box,
  color,
}: {
  title: string;
  emoji: string;
  items: string[];
  box: string;
  color: string;
}) {
  return (
    <div className={`rounded-xl border ${box} p-4 space-y-2`}>
      <div className={`text-sm font-bold ${color}`}>
        {emoji} {title}
      </div>
      <ul className="space-y-2">
        {items.map((it, i) => (
          <li key={i} className="text-gray-800 text-base leading-relaxed flex gap-2">
            <span className="text-gray-400 shrink-0">·</span>
            <span>{it}</span>
          </li>
        ))}
      </ul>
    </div>
  );
}
