/**
 * 망각 곡선 복습 스케줄링 (Spaced Repetition)
 *
 * 점수에 따라 다음 복습 시점을 결정:
 * - 80+ : 다음 단계로 (간격 늘림)
 * - 60-79: 같은 단계 유지 (간격 그대로)
 * - 60-  : 1일로 리셋
 */

export type ReviewStage = "new" | "d1" | "d3" | "d7" | "d21" | "d60" | "mastered";

const STAGE_ORDER: ReviewStage[] = ["new", "d1", "d3", "d7", "d21", "d60", "mastered"];
const INTERVAL_DAYS: Record<ReviewStage, number> = {
  new: 1,
  d1: 3,
  d3: 7,
  d7: 21,
  d21: 60,
  d60: 60,
  mastered: 0,
};

export interface ScheduleInput {
  currentStage: ReviewStage;
  score: number;
}

export interface ScheduleOutput {
  nextStage: ReviewStage;
  intervalDays: number;
  nextReviewAt: Date;
}

export function nextSchedule(input: ScheduleInput): ScheduleOutput {
  const { currentStage, score } = input;

  if (currentStage === "mastered") {
    return {
      nextStage: "mastered",
      intervalDays: 0,
      nextReviewAt: new Date("2999-12-31"),
    };
  }

  let nextStage: ReviewStage;
  if (score >= 80) {
    // 다음 단계로 진급
    const idx = STAGE_ORDER.indexOf(currentStage);
    nextStage = STAGE_ORDER[Math.min(idx + 1, STAGE_ORDER.length - 1)];
  } else if (score >= 60) {
    // 같은 단계 유지
    nextStage = currentStage;
  } else {
    // 1일로 리셋
    nextStage = "d1";
  }

  if (nextStage === "mastered") {
    return {
      nextStage: "mastered",
      intervalDays: 0,
      nextReviewAt: new Date("2999-12-31"),
    };
  }

  const intervalDays = INTERVAL_DAYS[nextStage];
  const nextReviewAt = new Date(Date.now() + intervalDays * 24 * 60 * 60 * 1000);
  return { nextStage, intervalDays, nextReviewAt };
}

export const STAGE_LABELS: Record<ReviewStage, string> = {
  new: "처음",
  d1: "1일 복습",
  d3: "3일 복습",
  d7: "7일 복습",
  d21: "21일 복습",
  d60: "60일 복습",
  mastered: "숙달",
};
