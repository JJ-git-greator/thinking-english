import Link from "next/link";

/**
 * 학습 흐름 시각화 — 어디 페이지에 있든 학생이 전체 사이클을 한눈에 보고
 * 본인이 어디 단계인지 알 수 있게 한다.
 *
 * 사이클:
 *   📖 깊이 읽기 → 🎯 유형 훈련 → 🔁 오늘의 복습 → (다시 깊이 읽기)
 */

export type FlowStep = "deep" | "drill" | "review";

interface Props {
  current?: FlowStep;
  compact?: boolean;
}

const STEPS: {
  key: FlowStep;
  emoji: string;
  title: string;
  short: string;
  desc: string;
  href: string;
  color: string;
  ring: string;
}[] = [
  {
    key: "deep",
    emoji: "📖",
    title: "단락 깊이 읽기",
    short: "깊이 읽기",
    desc: "한 단락을 3번 다른 각도로 — 핵심 두 문장 → 어법·구조 → 한국어 재구성",
    href: "/learn/passages",
    color: "from-amber-400 to-yellow-500",
    ring: "ring-amber-400",
  },
  {
    key: "drill",
    emoji: "🎯",
    title: "유형 집중 훈련",
    short: "유형 훈련",
    desc: "주제·빈칸·어휘 객관식 10문제 → 즉시 채점 → 약점 자동 재등장",
    href: "/learn/quiz",
    color: "from-sky-500 to-blue-600",
    ring: "ring-blue-500",
  },
  {
    key: "review",
    emoji: "🔁",
    title: "오늘의 복습",
    short: "복습",
    desc: "며칠 전 푼 단락이 1·3·7·21·60일 간격으로 자동 재등장",
    href: "/learn/review",
    color: "from-emerald-500 to-green-600",
    ring: "ring-emerald-500",
  },
];

export default function LearningFlow({ current, compact }: Props) {
  if (compact) {
    // 인라인 좁은 버전 — 페이지 헤더 옆 등
    return (
      <div className="flex items-center gap-1 text-xs">
        {STEPS.map((s, i) => (
          <div key={s.key} className="flex items-center gap-1">
            <Link
              href={s.href}
              className={`inline-flex items-center gap-1 px-2 py-1 rounded-md ${
                current === s.key
                  ? "bg-gray-900 text-white"
                  : "bg-gray-100 text-gray-600 hover:bg-gray-200"
              }`}
            >
              <span>{s.emoji}</span>
              <span className="font-medium">{s.short}</span>
            </Link>
            {i < STEPS.length - 1 && <span className="text-gray-300">→</span>}
          </div>
        ))}
      </div>
    );
  }

  return (
    <div className="bg-white border rounded-2xl p-5 sm:p-6 shadow-sm">
      <div className="text-xs text-gray-500 font-semibold mb-3">학습 흐름</div>
      <div className="grid sm:grid-cols-3 gap-3 sm:gap-4">
        {STEPS.map((s, i) => {
          const isCurrent = current === s.key;
          return (
            <Link
              key={s.key}
              href={s.href}
              className={`relative block rounded-xl border-2 p-4 transition group ${
                isCurrent
                  ? `border-transparent bg-gradient-to-br ${s.color} text-white shadow-md`
                  : "border-gray-100 bg-gray-50 hover:bg-white hover:border-gray-200"
              }`}
            >
              {isCurrent && (
                <span className="absolute -top-2 right-3 text-[10px] font-bold bg-white text-gray-800 px-2 py-0.5 rounded-full shadow">
                  지금 여기
                </span>
              )}
              <div className="flex items-center gap-2 mb-2">
                <span className="text-2xl">{s.emoji}</span>
                <span className="text-xs font-bold opacity-70">{i + 1}단계</span>
              </div>
              <div className={`font-bold mb-1 ${isCurrent ? "" : "text-gray-900"}`}>
                {s.title}
              </div>
              <div className={`text-xs leading-relaxed ${isCurrent ? "text-white/90" : "text-gray-600"}`}>
                {s.desc}
              </div>
            </Link>
          );
        })}
      </div>
      <p className="text-xs text-gray-400 mt-4">
        세 단계가 사이클을 이루며 반복됩니다. 한 단계만 해도 도움이 되지만, 셋이 같이 돌 때 가장
        효과적이에요.
      </p>
    </div>
  );
}
