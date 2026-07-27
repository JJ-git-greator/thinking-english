import Link from "next/link";
import { notFound, redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";

const TOPIC_KO: Record<string, string> = {
  main_idea: "주제·요지",
  blank: "빈칸 추론",
  vocabulary: "문맥 어휘",
  grammar: "어법",
};

/**
 * 지문 묶음 문제 풀기 — 방금 읽은 그 지문에서 나온 문제만 푼다.
 * (새 지문 10개를 들이미는 카테고리 모드와 분리)
 */
export default async function PassageQuizPage({
  params,
  searchParams,
}: {
  params: { id: string };
  searchParams?: { err?: string };
}) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) redirect("/login");
  const userId = userResp.user.id;

  const { data: passage } = await supabase
    .from("te_passages")
    .select("id, title, difficulty")
    .eq("id", params.id)
    .maybeSingle();
  if (!passage) notFound();

  const { data: questions } = await supabase
    .from("te_questions")
    .select("id, topic")
    .eq("passage_id", passage.id);

  const qs = questions ?? [];
  const byTopic = new Map<string, number>();
  for (const q of qs) byTopic.set(q.topic, (byTopic.get(q.topic) ?? 0) + 1);

  // 이 지문 문제로 이미 푼 기록
  const { data: attempts } = qs.length
    ? await supabase
        .from("te_question_attempts")
        .select("id, session_id, is_correct, answered_at")
        .eq("user_id", userId)
        .in(
          "question_id",
          qs.map((q) => q.id),
        )
        .not("answered_at", "is", null)
        .order("answered_at", { ascending: false })
    : { data: [] as any[] };

  const lastSessionId = attempts?.[0]?.session_id ?? null;
  const solved = attempts?.length ?? 0;
  const correct = (attempts ?? []).filter((a) => a.is_correct === true).length;

  return (
    <div className="space-y-6">
      <Link
        href={`/learn/passages/${passage.id}`}
        className="inline-flex items-center text-sm text-gray-500 hover:text-gray-900"
      >
        ← {passage.title}
      </Link>

      <div className="bg-gradient-to-r from-sky-500 to-blue-700 text-white rounded-2xl p-6 sm:p-8 shadow-md">
        <div className="text-xs font-semibold text-sky-100 mb-1">
          🎯 마지막 단계 · 이 지문 문제 풀기
        </div>
        <h1 className="text-2xl sm:text-3xl font-bold leading-tight">
          {passage.title}
        </h1>
        <p className="text-sky-50 mt-2 text-sm sm:text-base">
          방금 읽은 <b className="text-white">바로 이 지문</b>에서 나온 문제 {qs.length}개예요.
          새로운 지문을 다시 읽을 필요 없어요.
        </p>
      </div>

      {searchParams?.err === "no_questions" && (
        <div className="text-sm bg-amber-50 border border-amber-200 rounded-md px-4 py-3 text-amber-900">
          아직 이 지문에는 문제가 등록되지 않았어요.
        </div>
      )}

      <div className="bg-white border rounded-xl p-5 sm:p-6 space-y-4">
        <div className="flex flex-wrap gap-2">
          {[...byTopic.entries()].map(([t, n]) => (
            <span
              key={t}
              className="text-xs px-3 py-1 rounded-full bg-gray-100 text-gray-700 font-semibold"
            >
              {TOPIC_KO[t] ?? t} {n}문제
            </span>
          ))}
          {qs.length === 0 && (
            <span className="text-sm text-gray-500">등록된 문제가 없습니다.</span>
          )}
        </div>

        {solved > 0 && (
          <div className="text-sm text-gray-600">
            지금까지 이 지문 문제 <b>{solved}</b>번 풀었고 <b className="text-green-700">{correct}</b>번
            맞췄어요.
            {lastSessionId && (
              <Link
                href={`/learn/quiz/${lastSessionId}/review`}
                className="ml-2 text-brand-600 hover:text-brand-700 font-semibold"
              >
                지난 결과 보기 →
              </Link>
            )}
          </div>
        )}

        {qs.length > 0 && (
          <form action="/api/quiz/start" method="post">
            <input type="hidden" name="passageId" value={passage.id} />
            <button
              type="submit"
              className="w-full py-3.5 rounded-xl bg-brand-600 text-white font-bold text-base hover:bg-brand-700 active:scale-[0.99] transition shadow-sm"
            >
              이 지문 {qs.length}문제 풀기 →
            </button>
          </form>
        )}

        <p className="text-xs text-gray-500">
          답을 고른 뒤 <b>왜 골랐는지</b>도 적으면 좋아요(안 적어도 넘어갑니다). 다 풀면 바로 채점돼요.
        </p>
      </div>

      <div className="text-center">
        <Link
          href="/learn/quiz"
          className="text-sm text-gray-400 hover:text-gray-700"
        >
          다른 유형 훈련 보기
        </Link>
      </div>
    </div>
  );
}
