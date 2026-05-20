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

  // 오늘(현재 시각 이전) 복습 대상
  const { data: due } = await supabase
    .from("te_paragraph_reviews")
    .select(
      "paragraph_id, stage, last_score, review_count, next_review_at, te_paragraphs(ord, body, passage_id, te_passages(title))",
    )
    .eq("user_id", userId)
    .neq("stage", "mastered")
    .lte("next_review_at", nowIso)
    .order("next_review_at", { ascending: true });

  // 곧 예정된 (24시간 내) 복습
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

  // 숙달 (mastered)
  const { count: masteredCount } = await supabase
    .from("te_paragraph_reviews")
    .select("paragraph_id", { count: "exact", head: true })
    .eq("user_id", userId)
    .eq("stage", "mastered");

  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-3xl font-bold">오늘의 복습</h1>
        <p className="text-gray-500 mt-2">
          한 번 푼 단락이 잊혀지지 않게, 시간 간격을 두고 다시 만나요. 점수가
          높아질수록 다음 복습 간격이 길어집니다.
        </p>
      </div>

      <div className="grid grid-cols-3 gap-4">
        <StatCard label="지금 복습할 단락" value={`${due?.length ?? 0}개`} highlight />
        <StatCard label="24시간 내 예정" value={`${upcoming?.length ?? 0}개`} />
        <StatCard label="숙달 완료" value={`${masteredCount ?? 0}개`} />
      </div>

      <section className="space-y-3">
        <h2 className="text-lg font-semibold text-gray-800">지금 복습할 단락</h2>
        {(!due || due.length === 0) && (
          <p className="text-sm text-gray-400 text-center py-8">
            지금 당장 복습할 단락이 없습니다. 새 지문을 풀거나, 곧 예정된 복습을
            기다리세요.
          </p>
        )}
        <div className="space-y-2">
          {(due ?? []).map((r) => {
            const para = Array.isArray(r.te_paragraphs)
              ? r.te_paragraphs[0]
              : (r.te_paragraphs as any);
            const passage = para && (Array.isArray(para.te_passages) ? para.te_passages[0] : para.te_passages);
            return (
              <Link
                key={r.paragraph_id}
                href={`/learn/paragraphs/${r.paragraph_id}/reconstruct`}
                className="block bg-white border rounded-lg p-4 hover:shadow-md transition"
              >
                <div className="flex items-center justify-between gap-2">
                  <div>
                    <div className="font-medium text-gray-900">
                      {passage?.title}
                    </div>
                    <div className="text-xs text-gray-500 mt-0.5">
                      단락 {(para?.ord ?? 0) + 1} · {STAGE_LABELS[r.stage as ReviewStage]}
                      {r.last_score != null && ` · 지난 점수 ${r.last_score}`}
                    </div>
                  </div>
                  <span className="text-sm px-3 py-1.5 rounded-md bg-brand-600 text-white">
                    복습 →
                  </span>
                </div>
              </Link>
            );
          })}
        </div>
      </section>

      {upcoming && upcoming.length > 0 && (
        <section className="space-y-3">
          <h2 className="text-lg font-semibold text-gray-800">곧 예정 (24시간 내)</h2>
          <div className="space-y-1">
            {upcoming.map((r) => {
              const para = Array.isArray(r.te_paragraphs)
                ? r.te_paragraphs[0]
                : (r.te_paragraphs as any);
              const passage = para && (Array.isArray(para.te_passages) ? para.te_passages[0] : para.te_passages);
              return (
                <div
                  key={r.paragraph_id}
                  className="text-sm text-gray-600 flex items-center justify-between px-3 py-2 bg-gray-50 rounded"
                >
                  <span>
                    {passage?.title} · 단락 {(para?.ord ?? 0) + 1}
                  </span>
                  <span className="text-xs text-gray-400">
                    {timeUntil(r.next_review_at)}
                  </span>
                </div>
              );
            })}
          </div>
        </section>
      )}
    </div>
  );
}

function StatCard({ label, value, highlight }: { label: string; value: string; highlight?: boolean }) {
  return (
    <div
      className={`border rounded-lg p-5 ${
        highlight ? "bg-brand-50 border-brand-200" : "bg-white"
      }`}
    >
      <div className="text-sm text-gray-500">{label}</div>
      <div className={`text-2xl font-bold mt-1 ${highlight ? "text-brand-700" : ""}`}>
        {value}
      </div>
    </div>
  );
}

function timeUntil(iso: string): string {
  const diffMin = Math.round((new Date(iso).getTime() - Date.now()) / 60000);
  if (diffMin < 60) return `${diffMin}분 후`;
  return `${Math.round(diffMin / 60)}시간 후`;
}
