/**
 * 학생 레벨링 (강의 라인 549~557, 658~676 기반)
 *
 * - 하(low): 지스트 찾기만, 모의고사 30번 안쪽 정신
 * - 중(mid): 하 + 어휘까지
 * - 상(high): 빈칸 추론까지
 * - 극상(elite): 전체 + 어법
 */

export type LevelTier = "low" | "mid" | "high" | "elite";
export type DifficultyTier = "low" | "mid" | "high" | "elite";
export type QuestionTopic = "main_idea" | "blank" | "vocabulary" | "grammar";

export const LEVEL_LABELS: Record<LevelTier, string> = {
  low: "하",
  mid: "중",
  high: "상",
  elite: "극상",
};

const ALL_TOPICS: QuestionTopic[] = ["main_idea", "blank", "vocabulary", "grammar"];
const ALL_DIFFICULTIES: DifficultyTier[] = ["low", "mid", "high", "elite"];

/** 학생 레벨에 따라 풀 수 있는 난이도 목록 */
export function allowedDifficulties(level: LevelTier | null | undefined): DifficultyTier[] {
  const t: LevelTier = level ?? "mid";
  switch (t) {
    case "low":
      return ["low"];
    case "mid":
      return ["low", "mid"];
    case "high":
      return ["low", "mid", "high"];
    case "elite":
      return ALL_DIFFICULTIES;
  }
}

/** 학생 레벨에 따라 허용되는 카테고리 */
export function allowedTopics(level: LevelTier | null | undefined): QuestionTopic[] {
  const t: LevelTier = level ?? "mid";
  switch (t) {
    case "low":
      return ["main_idea"];
    case "mid":
      return ["main_idea", "vocabulary"];
    case "high":
      return ["main_idea", "blank", "vocabulary"];
    case "elite":
      return ALL_TOPICS;
  }
}

export function isTopicAllowed(
  level: LevelTier | null | undefined,
  topic: QuestionTopic,
): boolean {
  return allowedTopics(level).includes(topic);
}

/** 잠긴 카테고리에 대해 학생에게 보여줄 안내 메시지 */
export function lockReason(
  level: LevelTier | null | undefined,
  topic: QuestionTopic,
): string | null {
  if (isTopicAllowed(level, topic)) return null;
  const t: LevelTier = level ?? "mid";
  if (t === "low") {
    return "지금은 핵심 메시지 찾기에 집중하는 단계입니다. 그것부터 안정화한 뒤 풀어요.";
  }
  if (t === "mid" && topic === "blank") {
    return "빈칸 추론은 핵심 메시지·어휘가 안정된 다음에 들어갑니다.";
  }
  if (topic === "grammar") {
    return "어법(Structure) 모듈은 곧 열립니다.";
  }
  return "현재 레벨에서는 잠겨 있는 카테고리입니다.";
}
