import Link from "next/link";
import {
  resolveNeighbors,
  type ParagraphFlow,
  type StepKey,
} from "@/lib/paragraph-steps";

/**
 * 단락 학습 단계 네비게이션.
 * - 위: 이 단락의 전체 단계 레일 (현재 위치 강조, 완료 ✓, 아무 단계나 눌러 이동)
 * - 아래: 큰 [이전] / [다음] 버튼 — 한 단계씩 앞뒤로
 */
export default function StepNav({
  flow,
  current,
  position = "bottom",
}: {
  flow: ParagraphFlow;
  current: StepKey;
  position?: "top" | "bottom";
}) {
  const { prev, next, isLastStep } = resolveNeighbors(flow, current);
  const currentStep = flow.steps.find((s) => s.key === current);

  if (position === "top") {
    return (
      <div className="bg-white border rounded-xl px-3 py-3 sm:px-4">
        <div className="flex items-center justify-between gap-2 mb-2">
          <div className="text-xs text-gray-500">
            {flow.passage.title} · 단락 {flow.paragraph.index + 1}/{flow.paragraph.total}
          </div>
          {currentStep && (
            <div className="text-xs font-semibold text-gray-700">
              {currentStep.n}단계 / 총 {flow.steps.length}단계
            </div>
          )}
        </div>
        <div className="flex gap-1.5 overflow-x-auto pb-1">
          {flow.steps.map((s) => {
            const active = s.key === current;
            return (
              <Link
                key={s.key}
                href={s.href}
                className={`shrink-0 flex items-center gap-1.5 rounded-full border px-3 py-1.5 text-xs font-semibold transition active:scale-95 ${
                  active
                    ? "border-brand-500 bg-brand-50 text-brand-700"
                    : s.done
                      ? "border-emerald-200 bg-emerald-50 text-emerald-700 hover:bg-emerald-100"
                      : "border-gray-200 bg-white text-gray-500 hover:bg-gray-50"
                }`}
              >
                <span
                  className={`w-4 h-4 rounded-full text-[10px] flex items-center justify-center font-bold ${
                    active
                      ? "bg-brand-600 text-white"
                      : s.done
                        ? "bg-emerald-500 text-white"
                        : "bg-gray-200 text-gray-600"
                  }`}
                >
                  {s.done && !active ? "✓" : s.n}
                </span>
                <span className="whitespace-nowrap">{s.short}</span>
              </Link>
            );
          })}
        </div>
      </div>
    );
  }

  return (
    <div className="border-t pt-4 space-y-3">
      <div className="grid grid-cols-2 gap-3">
        <Link
          href={prev.href}
          className="flex flex-col items-start justify-center rounded-xl border-2 border-gray-200 bg-white px-4 py-3 hover:bg-gray-50 active:scale-[0.99] transition"
        >
          <span className="text-xs text-gray-400 font-semibold">← 이전</span>
          <span className="text-sm font-bold text-gray-700 line-clamp-1">{prev.label}</span>
        </Link>
        <Link
          href={next.href}
          className="flex flex-col items-end justify-center rounded-xl bg-brand-600 px-4 py-3 text-white hover:bg-brand-700 active:scale-[0.99] transition shadow-sm"
        >
          <span className="text-xs text-brand-100 font-semibold">
            {isLastStep ? "이 단락 끝 · 다음" : "다음 →"}
          </span>
          <span className="text-sm font-bold line-clamp-1">{next.label}</span>
        </Link>
      </div>
      <div className="text-center">
        <Link
          href={`/learn/passages/${flow.passage.id}`}
          className="text-xs text-gray-400 hover:text-gray-700"
        >
          지문 전체 화면으로
        </Link>
      </div>
    </div>
  );
}
