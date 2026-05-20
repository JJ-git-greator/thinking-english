import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import {
  allowedDifficulties,
  allowedTopics,
  isTopicAllowed,
  lockReason,
  LEVEL_LABELS,
  type LevelTier,
  type QuestionTopic,
} from "@/lib/leveling";
import { computeStats, TOPIC_KOREAN } from "@/lib/weakness";

const TOPIC_LABELS: Record<QuestionTopic, { title: string; desc: string; color: string }> = {
  main_idea: {
    title: "주제 · 요지 · 제목",
    desc: "단락의 중심 메시지를 잡는 훈련",
    color: "border-amber-300 bg-amber-50",
  },
  blank: {
    title: "빈칸 추론",
    desc: "맥락 단서로 빠진 표현 찾기",
    color: "border-sky-300 bg-sky-50",
  },
  vocabulary: {
    title: "어휘 (문맥)",
    desc: "단어가 아닌 맥락에서 의미 추론",
    color: "border-emerald-300 bg-emerald-50",
  },
  grammar: {
    title: "어법",
    desc: "주어·동사 일치, 시제, 태를 단계로 점검 (준비 중)",
    color: "border-gray-200 bg-gray-50",
  },
};

const ALL_TOPICS: QuestionTopic[] = ["main_idea", "blank", "vocabulary", "grammar"];

export default async function QuizHomePage({
  searchParams,
}: {
  searchParams?: { err?: string };
}) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) redirect("/login");

  // Caller profile (for level)
  const { data: profile } = await supabase
    .from("te_profiles")
    .select("level_tier, display_name")
    .eq("id", userResp.user.id)
    .maybeSingle();
  const level = (profile?.level_tier ?? null) as LevelTier | null;
  const allowedDiff = allowedDifficulties(level);

  // Available question counts per topic, filtered to allowed difficulty
  const counts: Record<QuestionTopic, number> = {
    main_idea: 0,
    blank: 0,
    vocabulary: 0,
    grammar: 0,
  };
  for (const t of ALL_TOPICS) {
    const { count } = await supabase
      .from("te_questions")
      .select("id", { count: "exact", head: true })
      .eq("topic", t)
      .in("difficulty", allowedDiff);
    counts[t] = count ?? 0;
  }

  // Recent sessions
  const { data: recent } = await supabase
    .from("te_quiz_sessions")
    .select("id, topic, total_correct, completed_at, remediation_done, started_at")
    .eq("user_id", userResp.user.id)
    .order("started_at", { ascending: false })
    .limit(5);

  // 약점 분석: 최근 50개 답안의 카테고리별 정답률
  const { data: recentAttempts } = await supabase
    .from("te_question_attempts")
    .select("is_correct, te_questions(topic)")
    .eq("user_id", userResp.user.id)
    .not("is_correct", "is", null)
    .order("answered_at", { ascending: false })
    .limit(50);
  const myTopics = allowedTopics(level);
  const attemptRows = (recentAttempts ?? []).map((a) => {
    const q = Array.isArray(a.te_questions) ? a.te_questions[0] : (a.te_questions as any);
    return { topic: q?.topic as QuestionTopic, is_correct: a.is_correct };
  }).filter((a) => a.topic && myTopics.includes(a.topic));
  const stats = computeStats(attemptRows);
  const enoughData = stats.length > 0 && stats.every((s) => s.total >= 5);

  const err = searchParams?.err;

  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-3xl font-bold">10문제 단위 학습</h1>
        <p className="text-gray-500 mt-2">
          10문제씩 풀고 바로 채점합니다. 오답에는 <b>왜 그렇게 골랐는지 한 줄</b>을
          남겨야 다음 묶음으로 넘어갑니다. 문제 수를 채우는 학습이 아니라,
          <b> 한 문제마다 사고를 점검</b>하는 학습이에요.
        </p>
      </div>

      <div className="bg-white border rounded-lg px-5 py-3 text-sm text-gray-600 flex items-center gap-3">
        <span>현재 단계:</span>
        <span className="font-semibold text-gray-900">
          {level ? LEVEL_LABELS[level] : "미설정 (기본 중)"}
        </span>
        <span className="text-xs text-gray-400">— 단계에 따라 풀 수 있는 카테고리가 달라집니다</span>
      </div>

      {err === "topic_locked" && (
        <div className="text-sm bg-amber-50 border border-amber-200 rounded-md p-3 text-amber-900">
          지금 단계에서는 열려 있지 않은 카테고리예요. 다른 카테고리부터 풀어 주세요.
        </div>
      )}
      {err === "no_topics" && (
        <div className="text-sm bg-amber-50 border border-amber-200 rounded-md p-3 text-amber-900">
          현재 단계에서 열린 카테고리가 없습니다.
        </div>
      )}

      {/* 약점 집중 모드 추천 */}
      <section className="bg-gradient-to-r from-brand-50 to-amber-50 border border-brand-200 rounded-lg p-5">
        <div className="flex items-start justify-between gap-4 flex-wrap">
          <div className="flex-1 min-w-0 space-y-1">
            <h2 className="text-lg font-semibold text-brand-900">🎯 약점 집중 모드</h2>
            {enoughData ? (
              <p className="text-sm text-gray-700">
                지금까지의 정답률을 보고 <b>가장 약한 카테고리에 6문제</b>, 나머지 카테고리에
                나머지 4문제를 자동 배분해서 10문제를 만들어줍니다.
              </p>
            ) : (
              <p className="text-sm text-gray-700">
                먼저 카테고리별 5문제 이상씩 풀면, 가장 약한 카테고리를 자동으로 더 자주
                노출해주는 모드가 활성화됩니다.
              </p>
            )}
            {enoughData && stats.length > 0 && (
              <div className="flex gap-3 text-xs text-gray-600 mt-2 flex-wrap">
                {stats.map((s) => (
                  <span key={s.topic}>
                    {TOPIC_KOREAN[s.topic]} {Math.round(s.accuracy * 100)}%
                    <span className="text-gray-400"> ({s.correct}/{s.total})</span>
                  </span>
                ))}
              </div>
            )}
          </div>
          <form action="/api/quiz/start-adaptive" method="post">
            <button
              type="submit"
              className="px-5 py-2.5 rounded-md bg-brand-600 text-white font-semibold hover:bg-brand-700 whitespace-nowrap"
            >
              약점 집중 시작
            </button>
          </form>
        </div>
      </section>
      {err === "no_questions" && (
        <div className="text-sm bg-amber-50 border border-amber-200 rounded-md p-3 text-amber-900">
          현재 단계에서 풀 수 있는 문제가 부족합니다. 선생님께 문제 추가를 요청하세요.
        </div>
      )}

      <section className="space-y-3">
        <h2 className="text-lg font-semibold text-gray-800">카테고리 선택</h2>
        <div className="grid sm:grid-cols-2 gap-3">
          {ALL_TOPICS.map((t) => {
            const meta = TOPIC_LABELS[t];
            const n = counts[t];
            const allowed = isTopicAllowed(level, t) && t !== "grammar";
            const empty = n < 1;
            const lock = lockReason(level, t);
            const disabled = !allowed || empty;

            const Card = (
              <div
                className={`border rounded-lg p-5 transition ${meta.color} ${
                  disabled
                    ? "opacity-60 cursor-not-allowed"
                    : "hover:shadow-md cursor-pointer"
                }`}
              >
                <div className="flex items-center justify-between">
                  <h3 className="font-semibold text-gray-900">
                    {!allowed && "🔒 "}
                    {meta.title}
                  </h3>
                  <span className="text-xs text-gray-500">
                    {!allowed ? "잠김" : empty ? "문제 없음" : `${n}문제`}
                  </span>
                </div>
                <p className="text-sm text-gray-600 mt-1">{meta.desc}</p>
                {!allowed && lock && (
                  <p className="text-xs text-gray-500 mt-2 italic">{lock}</p>
                )}
                {allowed && empty && (
                  <p className="text-xs text-gray-500 mt-2 italic">
                    현재 레벨에서 풀 만한 문제가 더 필요합니다.
                  </p>
                )}
              </div>
            );
            return disabled ? (
              <div key={t}>{Card}</div>
            ) : (
              <form key={t} action="/api/quiz/start" method="post">
                <input type="hidden" name="topic" value={t} />
                <button type="submit" className="w-full text-left">
                  {Card}
                </button>
              </form>
            );
          })}
        </div>
      </section>

      <section className="space-y-3">
        <h2 className="text-lg font-semibold text-gray-800">최근 풀이</h2>
        {(!recent || recent.length === 0) && (
          <p className="text-sm text-gray-400">아직 풀이 기록이 없습니다.</p>
        )}
        {recent && recent.length > 0 && (
          <div className="bg-white border rounded-lg overflow-hidden">
            <table className="w-full text-sm">
              <thead className="bg-gray-50 text-gray-600">
                <tr>
                  <th className="text-left px-4 py-2 font-medium">카테고리</th>
                  <th className="text-left px-4 py-2 font-medium">상태</th>
                  <th className="text-right px-4 py-2 font-medium">정답</th>
                  <th className="text-right px-4 py-2 font-medium">시작</th>
                  <th className="text-right px-4 py-2 font-medium"></th>
                </tr>
              </thead>
              <tbody>
                {recent.map((s) => {
                  const meta = TOPIC_LABELS[s.topic as QuestionTopic];
                  const status = s.completed_at
                    ? s.remediation_done
                      ? "완료"
                      : "오답 교정 필요"
                    : "진행 중";
                  const nextHref = s.completed_at
                    ? `/learn/quiz/${s.id}/review`
                    : `/learn/quiz/${s.id}/play`;
                  return (
                    <tr key={s.id} className="border-t">
                      <td className="px-4 py-2">{meta?.title ?? s.topic}</td>
                      <td className="px-4 py-2 text-gray-600">{status}</td>
                      <td className="px-4 py-2 text-right">
                        {s.total_correct != null ? `${s.total_correct}/10` : "—"}
                      </td>
                      <td className="px-4 py-2 text-right text-gray-500">
                        {new Date(s.started_at).toLocaleString("ko-KR")}
                      </td>
                      <td className="px-4 py-2 text-right">
                        <Link
                          href={nextHref}
                          className="text-brand-600 hover:underline"
                        >
                          {s.completed_at && !s.remediation_done
                            ? "교정하기"
                            : s.completed_at
                              ? "결과 보기"
                              : "이어풀기"}
                        </Link>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        )}
      </section>
    </div>
  );
}
