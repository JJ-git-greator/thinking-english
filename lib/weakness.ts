/**
 * 학생 약점 유형 분석.
 * 최근 답안을 보고 카테고리별 정답률을 계산하고,
 * 가장 약한 카테고리를 강조한 10문제 분포를 만들어 반환.
 */

import type { QuestionTopic } from "@/lib/leveling";

export interface CategoryStats {
  topic: QuestionTopic;
  total: number;
  correct: number;
  accuracy: number; // 0~1
}

export interface AdaptivePlan {
  stats: CategoryStats[];
  weakestTopic: QuestionTopic | null;
  distribution: Record<QuestionTopic, number>; // 10문제 중 각 카테고리 몇 개
}

export function computeStats(
  attempts: { topic: QuestionTopic; is_correct: boolean | null }[],
): CategoryStats[] {
  const topicMap = new Map<QuestionTopic, { total: number; correct: number }>();
  for (const a of attempts) {
    if (a.is_correct === null) continue;
    const t = a.topic;
    const cur = topicMap.get(t) ?? { total: 0, correct: 0 };
    cur.total++;
    if (a.is_correct) cur.correct++;
    topicMap.set(t, cur);
  }
  return Array.from(topicMap.entries()).map(([topic, v]) => ({
    topic,
    total: v.total,
    correct: v.correct,
    accuracy: v.total === 0 ? 0 : v.correct / v.total,
  }));
}

/**
 * 적응형 분포 계산
 * - 모든 카테고리가 일정 횟수 이상 풀려야 (>=5) 약점 판정 가능
 * - 가장 약한 카테고리에 60%, 나머지 허용 카테고리에 균등 분배
 * - 충분한 데이터 없으면 균등 분배
 */
export function adaptiveDistribution(
  stats: CategoryStats[],
  allowedTopics: QuestionTopic[],
  batchSize = 10,
): AdaptivePlan {
  const allowed = stats.filter((s) => allowedTopics.includes(s.topic));
  const enoughData = allowed.length > 0 && allowed.every((s) => s.total >= 5);

  const distribution: Record<QuestionTopic, number> = {
    main_idea: 0,
    blank: 0,
    vocabulary: 0,
    grammar: 0,
  };

  if (!enoughData || allowedTopics.length === 0) {
    // 균등 분배
    const per = Math.floor(batchSize / allowedTopics.length);
    let remainder = batchSize - per * allowedTopics.length;
    for (const t of allowedTopics) {
      distribution[t] = per + (remainder > 0 ? 1 : 0);
      if (remainder > 0) remainder--;
    }
    return { stats, weakestTopic: null, distribution };
  }

  // 가장 약한 카테고리 (정답률 최저)
  const weakest = allowed.reduce((a, b) => (a.accuracy < b.accuracy ? a : b));
  const otherTopics = allowedTopics.filter((t) => t !== weakest.topic);

  const weakCount = Math.round(batchSize * 0.6);
  const remaining = batchSize - weakCount;
  const perOther = otherTopics.length > 0 ? Math.floor(remaining / otherTopics.length) : 0;
  let leftover = remaining - perOther * otherTopics.length;

  distribution[weakest.topic] = weakCount;
  for (const t of otherTopics) {
    distribution[t] = perOther + (leftover > 0 ? 1 : 0);
    if (leftover > 0) leftover--;
  }

  return { stats, weakestTopic: weakest.topic, distribution };
}

export const TOPIC_KOREAN: Record<QuestionTopic, string> = {
  main_idea: "주제",
  blank: "빈칸",
  vocabulary: "어휘",
  grammar: "어법",
};
