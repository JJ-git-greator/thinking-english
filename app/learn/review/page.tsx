import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { STAGE_LABELS, type ReviewStage } from "@/lib/review-schedule";

export default async function ReviewTodayPage() {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) redirect("/login");
  const userId = userResp.user.id;

  const nowIso = new Date().toISOString();

  const { data: due } = await supabase
    .from("te_paragraph_reviews")
    .select(
      "paragraph_id, stage, last_score, review_count, next_review_at, te_paragraphs(ord, body, passage_id, te_passages(title, difficulty))",
    )
    .eq("user_id", userId)
    .neq("stage", "mastered")
    .lte("next_review_at", nowIso)
    .order("next_review_at", { ascending: true });

  const tomorrowIso = new Date(Date.now() + 24 * 60 * 60 * 1000).toISOString();
  const { data: upcoming } = await supabase
    .from("te_paragraph_reviews")
    .select(
      "paragraph_id, stage, next_review_at, te_paragraphs(ord, te_passages(title))",
    )
    .eq("user_id", userId)
    .neq("stage", "mastered")
    .gt("next_review_at", nowIso)
    .lte("next_review_at", tomorrowIso)
    .order("next_review_at", { ascending: true })
    .limit(5);

  const { count: masteredCount } = await supabase
    .from("te_paragraph_reviews")
    .select("paragraph_id", { count: "exact", head: true })
    .eq("user_id", userId)
    .eq("stage", "mastered");

  const dueCount = due?.length ?? 0;

  return (
    <div className="space-y-8">
      {/* 히어로 헤더 */}
      <div className="relative overflow-hidden rounded-2xl bg-gradient-to-br from-brand-500 to-brand-700 text-white p-7 sm:p-9 shadow-md">
        <div className="absolute inset-0 opacity-10 bg-[radial-gradient(circle_at_20%_30%,white,transparent_50%)]" />
        <div className="relative space-y-3">
          <div className="text-sm text-brand-100">오늘의 복습</div>
          <h1 className="text-3xl sm:text-4xl font-bold leading-tight">
            {dueCount > 0 ? `지금 ${dueCount}개 단락이 기다리고 있어요` : "지금은 복습할 게 없어요"}
          </h1>
          <p className="text-brand-50 text-sm sm:text-base max-w-xl">
            한 번 푼 단락도 시간이 지나면 흐릿해져요. 시스템이 잊을 만한 시점에 다시 띄워주니
            점수를 유지하면 간격이 점점 길어집니다.
          </p>
        </div>
      </div>

      {/* 통계 3장 */}
      <div className="grid grid-cols-3 gap-3 sm:gap-4">
        <Stat label="오늘 풀 단락" value={dueCount} accent="brand" big />
        <Stat label="24시간 내 예정" value={upcoming?.length ?? 0} />
        <Stat label="숙달 완료" value={masteredCount ?? 0} accent="green" />
      </div>

      {/* 지금 복습할 단락 */}
      <section className="space-y-3">
        <div className="flex items-baseline justify-between">
          <h2 className="text-xl font-bold text-gray-900">지금 복습할 단락</h2>
          <span className="text-sm text-gray-400">{dueCount}개</span>
        </div>

        {dueCount === 0 ? (
          <div className="bg-white border-2 border-dashed border-gray-200 rounded-xl py-16 text-center">
            <div className="text-5xl mb-3">🎉</div>
            <p className="text-gray-700 font-medium">오늘은 복습이 없어요!</p>
            <p className="text-sm text-gray-500 mt-1">
              새 지문을 풀면 자동으로 복습 일정에 추가됩니다.
            </p>
            <Link
              href="/learn/passages"
              className="inline-block mt-4 px-5 py-2 rounded-md bg-brand-600 text-white text-sm font-semibold hover:bg-brand-700"
            >
              새 지문 풀러가기
            </Link>
          </div>
        ) : (
          <div className="grid sm:grid-cols-2 gap-3">
            {(due ?? []).map((r) => {
              const para = Array.isArray(r.te_paragraphs)
                ? r.te_paragraphs[0]
                : (r.te_paragraphs as any);
              const passage =
                para && (Array.isArray(para.te_passages) ? para.te_passages[0] : para.te_passages);
              const tier = passage?.difficulty as string | undefined;
              const tierColor = TIER_DOT[tier ?? "none"];
              return (
                <Link
                  key={r.paragraph_id}
                  href={`/learn/paragraphs/${r.paragraph_id}/reconstruct`}
                  className="group block bg-white border border-gray-200 hover:border-brand-300 hover:shadow-md rounded-xl p-5 transition"
                >
                  <div className="flex items-start justify-between gap-2 mb-2">
                    <div className="flex items-center gap-2 text-xs">
                      <span className={`w-2 h-2 rounded-full ${tierColor}`} />
                      <span className="text-gray-500">{STAGE_LABELS[r.stage as ReviewStage]}</span>
                      <span className="text-gray-300">·</span>
                      <span className="text-gray-500">단락 {(para?.ord ?? 0) + 1}</span>
                    </div>
                    {r.last_score != null && (
                      <span
                        className={`text-xs font-semibold px-2 py-0.5 rounded ${
                          r.last_score >= 80
                            ? "bg-green-100 text-green-800"
                            : r.last_score >= 60
                              ? "bg-yellow-100 text-yellow-800"
                              : "bg-red-100 text-red-800"
                        }`}
                      >
                        지난 {r.last_score}점
                      </span>
                    )}
                  </div>
                  <h3 className="font-semibold text-gray-900 group-hover:text-brand-700 line-clamp-2 min-h-[2.5rem]">
                    {passage?.title}
                  </h3>
                  <div className="flex items-center justify-between mt-3 text-sm">
                    <span className="text-gray-400 text-xs">{r.review_count}회 복습</span>
                    <span className="text-brand-600 font-semibold group-hover:translate-x-1 transition-transform">
                      복습 시작 →
                    </span>
                  </div>
                </Link>
              );
            })}
          </div>
        )}
      </section>

      {/* 곧 예정 */}
      {upcoming && upcoming.length > 0 && (
        <section className="space-y-3">
          <h2 className="text-lg font-bold text-gray-700">곧 예정 (24시간 내)</h2>
          <div className="bg-white border rounded-xl divide-y">
            {upcoming.map((r) => {
              const para = Array.isArray(r.te_paragraphs)
                ? r.te_paragraphs[0]
                : (r.te_paragraphs as any);
              const passage =
                para && (Array.isArray(para.te_passages) ? para.te_passages[0] : para.te_passages);
              return (
                <div
                  key={r.paragraph_id}
                  className="flex items-center justify-between px-4 py-2.5 text-sm"
                >
                  <span className="text-gray-700">
                    <span className="font-medium">{passage?.title}</span>
                    <span className="text-gray-400"> · 단락 {(para?.ord ?? 0) + 1}</span>
                  </span>
                  <span className="text-xs text-gray-500">⏱ {timeUntil(r.next_review_at)}</span>
                </div>
              );
            })}
          </div>
        </section>
      )}
    </div>
  );
}

const TIER_DOT: Record<string, string> = {
  low: "bg-emerald-500",
  mid: "bg-amber-500",
  high: "bg-orange-500",
  elite: "bg-rose-500",
  none: "bg-gray-300",
};

function Stat({
  label,
  value,
  accent,
  big,
}: {
  label: string;
  value: number;
  accent?: "brand" | "green";
  big?: boolean;
}) {
  const accentClass =
    accent === "brand"
      ? "border-brand-200 bg-brand-50"
      : accent === "green"
        ? "border-emerald-200 bg-emerald-50"
        : "border-gray-200 bg-white";
  const numColor =
    accent === "brand"
      ? "text-brand-700"
      : accent === "green"
        ? "text-emerald-700"
        : "text-gray-900";
  return (
    <div className={`border rounded-xl p-4 sm:p-5 ${accentClass}`}>
      <div className="text-xs text-gray-600">{label}</div>
      <div className={`font-bold mt-1 ${numColor} ${big ? "text-3xl sm:text-4xl" : "text-2xl"}`}>
        {value}
        <span className="text-base font-normal text-gray-400 ml-1">개</span>
      </div>
    </div>
  );
}

function timeUntil(iso: string): string {
  const diffMin = Math.round((new Date(iso).getTime() - Date.now()) / 60000);
  if (diffMin < 60) return `${diffMin}분 후`;
  return `${Math.round(diffMin / 60)}시간 후`;
}
