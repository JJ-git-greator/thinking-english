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
import LearningFlow from "@/components/LearningFlow";

const TOPIC_META: Record<
  QuestionTopic,
  { title: string; desc: string; emoji: string; band: string; bg: string; text: string }
> = {
  main_idea: {
    title: "주제 · 요지 · 제목",
    desc: "단락의 중심 메시지를 잡는 훈련",
    emoji: "🎯",
    band: "bg-gradient-to-r from-amber-400 to-yellow-500",
    bg: "bg-gradient-to-br from-amber-50 to-yellow-50",
    text: "text-amber-800",
  },
  blank: {
    title: "빈칸 추론",
    desc: "맥락 단서로 빠진 표현 찾기",
    emoji: "🧩",
    band: "bg-gradient-to-r from-sky-400 to-blue-500",
    bg: "bg-gradient-to-br from-sky-50 to-blue-50",
    text: "text-sky-800",
  },
  vocabulary: {
    title: "어휘 (문맥)",
    desc: "단어가 아닌 맥락에서 의미 추론",
    emoji: "📚",
    band: "bg-gradient-to-r from-emerald-400 to-green-500",
    bg: "bg-gradient-to-br from-emerald-50 to-green-50",
    text: "text-emerald-800",
  },
  grammar: {
    title: "어법",
    desc: "주어·동사 일치, 시제, 태를 단계로 점검 (준비 중)",
    emoji: "📝",
    band: "bg-gradient-to-r from-gray-300 to-gray-400",
    bg: "bg-gradient-to-br from-gray-50 to-gray-100",
    text: "text-gray-700",
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

  const { data: profile } = await supabase
    .from("te_profiles")
    .select("level_tier, display_name")
    .eq("id", userResp.user.id)
    .maybeSingle();
  const level = (profile?.level_tier ?? null) as LevelTier | null;
  const allowedDiff = allowedDifficulties(level);

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

  const { data: recent } = await supabase
    .from("te_quiz_sessions")
    .select("id, topic, total_correct, completed_at, remediation_done, started_at, batch_size")
    .eq("user_id", userResp.user.id)
    .order("started_at", { ascending: false })
    .limit(5);

  const { data: recentAttempts } = await supabase
    .from("te_question_attempts")
    .select("is_correct, te_questions(topic)")
    .eq("user_id", userResp.user.id)
    .not("is_correct", "is", null)
    .order("answered_at", { ascending: false })
    .limit(50);
  const myTopics = allowedTopics(level);
  const attemptRows = (recentAttempts ?? [])
    .map((a) => {
      const q = Array.isArray(a.te_questions) ? a.te_questions[0] : (a.te_questions as any);
      return { topic: q?.topic as QuestionTopic, is_correct: a.is_correct };
    })
    .filter((a) => a.topic && myTopics.includes(a.topic));
  const stats = computeStats(attemptRows);
  const enoughData = stats.length > 0 && stats.every((s) => s.total >= 5);
  const weakest = enoughData
    ? stats.reduce((a, b) => (a.accuracy < b.accuracy ? a : b))
    : null;

  // ── 내가 읽은 지문 (깊이 읽기를 한 지문) → 그 지문 문제로 바로 연결 ───────────
  const { data: myGists } = await supabase
    .from("te_gist_notes")
    .select("paragraph_id, updated_at")
    .eq("user_id", userResp.user.id)
    .order("updated_at", { ascending: false })
    .limit(60);

  const studiedParagraphIds = Array.from(
    new Set((myGists ?? []).map((g) => g.paragraph_id)),
  );
  const { data: studiedParagraphs } = studiedParagraphIds.length
    ? await supabase
        .from("te_paragraphs")
        .select("id, passage_id")
        .in("id", studiedParagraphIds)
    : { data: [] as { id: string; passage_id: string }[] };

  // 최근 읽은 순서 유지
  const paraToPassage = new Map(
    (studiedParagraphs ?? []).map((p) => [p.id, p.passage_id]),
  );
  const studiedPassageIds: string[] = [];
  for (const g of myGists ?? []) {
    const pid = paraToPassage.get(g.paragraph_id);
    if (pid && !studiedPassageIds.includes(pid)) studiedPassageIds.push(pid);
  }
  const topPassageIds = studiedPassageIds.slice(0, 6);

  const { data: studiedPassages } = topPassageIds.length
    ? await supabase
        .from("te_passages")
        .select("id, title, difficulty")
        .in("id", topPassageIds)
    : { data: [] as any[] };
  const { data: passageQuestions } = topPassageIds.length
    ? await supabase
        .from("te_questions")
        .select("id, passage_id")
        .in("passage_id", topPassageIds)
    : { data: [] as any[] };
  const qCountByPassage = new Map<string, number>();
  for (const q of passageQuestions ?? []) {
    qCountByPassage.set(q.passage_id, (qCountByPassage.get(q.passage_id) ?? 0) + 1);
  }
  const passageById = new Map((studiedPassages ?? []).map((p: any) => [p.id, p]));
  const studiedCards = topPassageIds
    .map((id) => ({ passage: passageById.get(id), count: qCountByPassage.get(id) ?? 0 }))
    .filter((c) => c.passage && c.count > 0);

  const err = searchParams?.err;

  return (
    <div className="space-y-8">
      {/* 히어로 헤더 */}
      <div className="relative overflow-hidden rounded-2xl bg-gradient-to-br from-sky-500 to-blue-700 text-white p-7 sm:p-9 shadow-md">
        <div className="absolute inset-0 opacity-10 bg-[radial-gradient(circle_at_80%_30%,white,transparent_50%)]" />
        <div className="relative space-y-3">
          <div className="text-sm text-sky-100">🎯 유형 집중 훈련</div>
          <h1 className="text-3xl sm:text-4xl font-bold leading-tight">
            읽은 지문으로 바로 문제 풀기
          </h1>
          <p className="text-sky-50 text-sm sm:text-base max-w-2xl">
            기본은 <b className="text-white">방금 깊이 읽은 그 지문</b>의 문제입니다. 아래
            카테고리 훈련은 여러 지문을 섞어서 푸는 심화용이에요.
          </p>
        </div>
      </div>

      {/* 학습 흐름 */}
      <LearningFlow current="drill" />

      {/* 절차 안내 */}
      <div className="bg-sky-50 border border-sky-200 rounded-xl p-5 sm:p-6">
        <div className="text-sm font-bold text-sky-900 mb-3">어떻게 풀면 되나요?</div>
        <div className="space-y-2 text-sm text-gray-700">
          <Step num={1} title="문제 풀이" desc="한 문제씩 답을 고르고 [다음 문제]. 왜 골랐는지도 적으면 좋아요(안 적어도 넘어감)." />
          <Step num={2} title="즉시 채점" desc="다 풀면 자동 채점. 어떤 문제가 맞고 틀렸는지 바로 표시돼요." />
          <Step num={3} title="오답 정리" desc="틀린 문제는 '왜 틀렸는지' 한 줄 적어두면 다음에 같은 실수를 덜 합니다." />
          <Step num={4} title="약점 자동 추적" desc="카테고리별 정답률을 자동 분석해, 약한 유형이 더 자주 나옵니다." />
        </div>
      </div>

      {/* 레벨 표시 바 */}
      <div className="flex items-center gap-3 bg-white border rounded-xl px-5 py-3 text-sm">
        <div className="w-8 h-8 rounded-full bg-brand-100 text-brand-700 flex items-center justify-center font-bold">
          {level ? LEVEL_LABELS[level].charAt(0) : "?"}
        </div>
        <div className="flex-1">
          <div className="text-xs text-gray-500">현재 단계</div>
          <div className="font-semibold text-gray-900">
            {level ? LEVEL_LABELS[level] : "미설정 (기본 중)"}
          </div>
        </div>
        <span className="text-xs text-gray-400 hidden sm:block">
          단계에 따라 풀 수 있는 카테고리가 달라집니다
        </span>
      </div>

      {err === "topic_locked" && (
        <Alert>지금 단계에서는 열려 있지 않은 카테고리예요. 다른 카테고리부터 풀어 주세요.</Alert>
      )}
      {err === "no_topics" && <Alert>현재 단계에서 열린 카테고리가 없습니다.</Alert>}
      {err === "no_questions" && (
        <Alert>현재 단계에서 풀 수 있는 문제가 부족합니다. 선생님께 문제 추가를 요청하세요.</Alert>
      )}

      {/* 내가 읽은 지문으로 풀기 — 기본 경로 */}
      <section className="space-y-3">
        <div>
          <h2 className="text-xl font-bold text-gray-900">📖 내가 읽은 지문으로 풀기</h2>
          <p className="text-sm text-gray-600 mt-1">
            깊이 읽기를 끝낸 지문에서 바로 문제를 풉니다. 새 지문을 다시 읽을 필요 없어요.
          </p>
        </div>
        {studiedCards.length === 0 ? (
          <div className="text-sm text-gray-500 bg-white border border-dashed rounded-xl py-8 text-center">
            아직 깊이 읽기를 한 지문이 없어요.{" "}
            <Link href="/learn/passages" className="text-brand-600 font-semibold">
              단락 깊이 읽기부터 →
            </Link>
          </div>
        ) : (
          <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-3">
            {studiedCards.map(({ passage, count }) => (
              <form key={passage.id} action="/api/quiz/start" method="post">
                <input type="hidden" name="passageId" value={passage.id} />
                <button
                  type="submit"
                  className="w-full h-full text-left rounded-2xl border bg-white p-5 hover:shadow-md hover:-translate-y-0.5 transition-all duration-150"
                >
                  <div className="text-xs text-gray-400 font-semibold mb-1">
                    {count}문제 · 이 지문에서만
                  </div>
                  <div className="font-bold text-gray-900 leading-snug">{passage.title}</div>
                  <div className="text-sm font-semibold text-brand-600 mt-3">풀러 가기 →</div>
                </button>
              </form>
            ))}
          </div>
        )}
      </section>

      {/* 약점 집중 모드 — 히어로 */}
      <section className="relative overflow-hidden rounded-2xl bg-gradient-to-br from-brand-500 via-brand-600 to-amber-600 text-white p-6 sm:p-8 shadow-lg">
        <div className="absolute inset-0 opacity-10 bg-[radial-gradient(circle_at_80%_20%,white,transparent_60%)]" />
        <div className="relative flex flex-col sm:flex-row sm:items-end justify-between gap-5">
          <div className="space-y-2 max-w-xl">
            <div className="text-xs text-brand-100 font-semibold">🎯 약점 집중 모드</div>
            <h2 className="text-2xl sm:text-3xl font-bold leading-tight">
              {enoughData && weakest
                ? `약한 카테고리: ${TOPIC_KOREAN[weakest.topic]} ${Math.round(weakest.accuracy * 100)}%`
                : "데이터가 쌓이면 자동으로 활성화돼요"}
            </h2>
            <p className="text-brand-50 text-sm leading-relaxed">
              {enoughData
                ? "약한 카테고리에 6문제, 나머지에 4문제를 자동으로 배분해 10문제를 만들어줍니다."
                : "카테고리별 5문제 이상 풀면, 시스템이 가장 약한 유형을 자동으로 더 자주 노출합니다."}
            </p>
            {enoughData && stats.length > 0 && (
              <div className="flex gap-3 text-xs text-white/90 mt-2 flex-wrap">
                {stats.map((s) => (
                  <span
                    key={s.topic}
                    className="bg-white/15 px-2 py-1 rounded-md backdrop-blur-sm"
                  >
                    {TOPIC_KOREAN[s.topic]}{" "}
                    <b>{Math.round(s.accuracy * 100)}%</b>
                    <span className="text-white/60 ml-1">
                      ({s.correct}/{s.total})
                    </span>
                  </span>
                ))}
              </div>
            )}
          </div>
          {enoughData && (
            <form action="/api/quiz/start-adaptive" method="post">
              <button
                type="submit"
                className="px-6 py-3 rounded-lg bg-white text-brand-700 font-bold hover:bg-brand-50 shadow-md whitespace-nowrap"
              >
                약점 집중 시작 →
              </button>
            </form>
          )}
        </div>
      </section>

      {/* 카테고리 카드 */}
      <section className="space-y-4">
        <div>
          <h2 className="text-xl font-bold text-gray-900">🎯 카테고리 훈련 (심화)</h2>
          <p className="text-sm text-gray-600 mt-1">
            여러 지문에서 뽑은 10문제를 한 번에 풉니다. 지문이 매번 바뀌니 시간이 있을 때 하세요.
          </p>
        </div>
        <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
          {ALL_TOPICS.map((t) => {
            const meta = TOPIC_META[t];
            const n = counts[t];
            const allowed = isTopicAllowed(level, t) && t !== "grammar";
            const empty = n < 1;
            const lock = lockReason(level, t);
            const disabled = !allowed || empty;

            const Card = (
              <div
                className={`relative overflow-hidden rounded-2xl border shadow-sm ${meta.bg} ${
                  disabled ? "opacity-60" : "hover:shadow-lg hover:-translate-y-0.5"
                } transition-all duration-150`}
              >
                <div className={`h-1.5 ${meta.band}`} />
                <div className="p-5 sm:p-6 space-y-3">
                  <div className="flex items-start justify-between gap-2">
                    <div className="text-3xl">{meta.emoji}</div>
                    {!allowed ? (
                      <span className="text-xs px-2 py-0.5 rounded-full bg-white text-gray-500 font-semibold">
                        🔒 잠김
                      </span>
                    ) : (
                      <span className="text-xs px-2 py-0.5 rounded-full bg-white text-gray-700 font-semibold">
                        {empty ? "문제 없음" : `${n}문제`}
                      </span>
                    )}
                  </div>
                  <h3 className={`font-bold text-lg ${meta.text}`}>{meta.title}</h3>
                  <p className="text-sm text-gray-700">{meta.desc}</p>
                  {!allowed && lock && (
                    <p className="text-xs text-gray-500 italic">{lock}</p>
                  )}
                  {allowed && !empty && (
                    <div className={`text-sm font-semibold ${meta.text} pt-1`}>
                      시작하기 →
                    </div>
                  )}
                </div>
              </div>
            );

            return disabled ? (
              <div key={t} className="cursor-not-allowed">
                {Card}
              </div>
            ) : (
              <form key={t} action="/api/quiz/start" method="post">
                <input type="hidden" name="topic" value={t} />
                <button type="submit" className="w-full text-left block">
                  {Card}
                </button>
              </form>
            );
          })}
        </div>
      </section>

      {/* 최근 풀이 */}
      <section className="space-y-3">
        <h2 className="text-xl font-bold text-gray-900">최근 풀이</h2>
        {(!recent || recent.length === 0) ? (
          <div className="text-sm text-gray-400 bg-white border border-dashed rounded-xl py-8 text-center">
            아직 풀이 기록이 없습니다.
          </div>
        ) : (
          <div className="bg-white border rounded-xl divide-y overflow-hidden">
            {recent.map((s) => {
              const meta = TOPIC_META[s.topic as QuestionTopic];
              const status = s.completed_at
                ? s.remediation_done
                  ? { label: "완료", color: "bg-green-100 text-green-800" }
                  : { label: "오답 교정 필요", color: "bg-amber-100 text-amber-800" }
                : { label: "진행 중", color: "bg-gray-100 text-gray-700" };
              const nextHref = s.completed_at
                ? `/learn/quiz/${s.id}/review`
                : `/learn/quiz/${s.id}/play`;
              const linkLabel = s.completed_at && !s.remediation_done
                ? "교정하기"
                : s.completed_at
                  ? "결과 보기"
                  : "이어풀기";
              return (
                <div
                  key={s.id}
                  className="flex items-center justify-between gap-3 px-4 py-3 sm:px-5 sm:py-4 hover:bg-gray-50"
                >
                  <div className="flex items-center gap-3 min-w-0">
                    <div className="text-2xl">{meta?.emoji ?? "📝"}</div>
                    <div className="min-w-0">
                      <div className="font-medium text-gray-900 truncate">
                        {meta?.title ?? s.topic}
                      </div>
                      <div className="text-xs text-gray-500 truncate">
                        {new Date(s.started_at).toLocaleString("ko-KR")}
                      </div>
                    </div>
                  </div>
                  <div className="flex items-center gap-3 shrink-0">
                    <span className={`text-xs px-2 py-0.5 rounded-full ${status.color}`}>
                      {status.label}
                    </span>
                    {s.total_correct != null && (
                      <span className="text-sm font-semibold text-gray-700 hidden sm:inline">
                        {s.total_correct}/{s.batch_size}
                      </span>
                    )}
                    <Link
                      href={nextHref}
                      className="text-sm text-brand-600 hover:text-brand-700 font-medium"
                    >
                      {linkLabel} →
                    </Link>
                  </div>
                </div>
              );
            })}
          </div>
        )}
      </section>
    </div>
  );
}

function Step({ num, title, desc }: { num: number; title: string; desc: string }) {
  return (
    <div className="flex gap-3">
      <div className="shrink-0 w-7 h-7 rounded-full bg-sky-500 text-white text-sm font-bold flex items-center justify-center">
        {num}
      </div>
      <div className="flex-1">
        <span className="font-semibold text-gray-900">{title}</span>
        <span className="text-gray-600"> — {desc}</span>
      </div>
    </div>
  );
}

function Alert({ children }: { children: React.ReactNode }) {
  return (
    <div className="text-sm bg-amber-50 border border-amber-200 rounded-md px-4 py-3 text-amber-900 flex items-start gap-2">
      <span className="text-base">⚠️</span>
      <span>{children}</span>
    </div>
  );
}
