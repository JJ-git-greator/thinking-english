import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";

type Tier = "all" | "low" | "mid" | "high" | "elite";
const TIER_LABEL: Record<string, string> = {
  low: "하",
  mid: "중",
  high: "상",
  elite: "극상",
};
const TIER_COLOR: Record<string, string> = {
  low: "from-emerald-400 to-emerald-500",
  mid: "from-sky-400 to-sky-500",
  high: "from-violet-500 to-purple-500",
  elite: "from-fuchsia-500 to-rose-500",
};

export default async function ChunksLandingPage({
  searchParams,
}: {
  searchParams?: { tier?: string };
}) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) redirect("/login");
  const userId = userResp.user.id;

  const filterTier: Tier = (["all", "low", "mid", "high", "elite"] as Tier[]).includes(
    searchParams?.tier as Tier,
  )
    ? (searchParams!.tier as Tier)
    : "all";

  // 청크 문장이 존재하는 단락만 가져오기 (서버에서 group by 어려우므로 두 단계)
  const { data: chunkRows } = await supabase
    .from("te_chunk_sentences")
    .select("paragraph_id");
  const paragraphIds = Array.from(
    new Set((chunkRows ?? []).map((r) => r.paragraph_id)),
  );

  let paragraphs: any[] = [];
  if (paragraphIds.length > 0) {
    const { data } = await supabase
      .from("te_paragraphs")
      .select("id, ord, body, passage_id, te_passages(id, title, difficulty)")
      .in("id", paragraphIds)
      .order("ord", { ascending: true });
    paragraphs = data ?? [];
  }

  // 단락별 문장 수 + 학생 시도 횟수 집계
  const { data: sentCounts } = paragraphIds.length
    ? await supabase
        .from("te_chunk_sentences")
        .select("paragraph_id")
        .in("paragraph_id", paragraphIds)
    : { data: [] };
  const sentMap = new Map<string, number>();
  for (const s of sentCounts ?? []) {
    sentMap.set(s.paragraph_id, (sentMap.get(s.paragraph_id) ?? 0) + 1);
  }

  const { data: attempts } = paragraphIds.length
    ? await supabase
        .from("te_chunk_attempts")
        .select("paragraph_id, rating")
        .eq("user_id", userId)
        .in("paragraph_id", paragraphIds)
    : { data: [] };
  const attemptMap = new Map<string, { total: number; good: number }>();
  for (const a of attempts ?? []) {
    const cur = attemptMap.get(a.paragraph_id) ?? { total: 0, good: 0 };
    cur.total++;
    if (a.rating === 3) cur.good++;
    attemptMap.set(a.paragraph_id, cur);
  }

  // 난이도 필터
  const filtered = paragraphs.filter((p) => {
    const passage = Array.isArray(p.te_passages) ? p.te_passages[0] : p.te_passages;
    if (filterTier === "all") return true;
    return passage?.difficulty === filterTier;
  });

  // 지문별로 그룹
  type Group = { title: string; difficulty: string; paragraphs: any[] };
  const byPassage = new Map<string, Group>();
  for (const p of filtered) {
    const passage = Array.isArray(p.te_passages) ? p.te_passages[0] : p.te_passages;
    if (!passage) continue;
    const cur: Group = byPassage.get(passage.id) ?? {
      title: passage.title,
      difficulty: passage.difficulty,
      paragraphs: [],
    };
    cur.paragraphs.push(p);
    byPassage.set(passage.id, cur);
  }

  const tiers: Tier[] = ["all", "low", "mid", "high", "elite"];

  return (
    <div className="space-y-6">
      {/* 헤더 */}
      <div className="bg-gradient-to-r from-purple-500 to-fuchsia-500 text-white rounded-2xl p-6 sm:p-8 shadow-md">
        <div className="text-xs font-semibold text-purple-50 mb-1">
          📝 직독직해 훈련
        </div>
        <h1 className="text-2xl sm:text-3xl font-bold leading-tight mb-2">
          영어 어순 그대로, 끊어 읽고 즉시 해석
        </h1>
        <p className="text-purple-50 text-sm sm:text-base">
          청크 하나씩 공개되고, 한국어 의미를 떠올린 다음 확인합니다. 절대 되돌아가지
          않습니다 — 영어 어순에 머리를 맞추는 훈련이에요.
        </p>
      </div>

      {/* 안내 카드 */}
      <div className="bg-white border rounded-xl p-4 sm:p-5 space-y-2">
        <h2 className="font-bold text-gray-900">이렇게 진행해요</h2>
        <ol className="text-sm text-gray-700 space-y-1 list-decimal pl-5">
          <li>왼쪽 청크부터 영어로 한 번 읽기</li>
          <li>입속으로 한국어 의미 떠올리기</li>
          <li><b>한국어 의미 확인</b> 버튼 누르고 비교</li>
          <li>다음 청크로 — 절대 앞으로 되돌아가지 않기</li>
          <li>문장 끝나면 자가평가 (익숙 / 보통 / 다시)</li>
        </ol>
      </div>

      {/* 난이도 탭 */}
      <div className="flex flex-wrap gap-2">
        {tiers.map((t) => {
          const active = t === filterTier;
          const href = t === "all" ? "/learn/chunks" : `/learn/chunks?tier=${t}`;
          const label = t === "all" ? "전체" : TIER_LABEL[t];
          return (
            <Link
              key={t}
              href={href}
              className={`px-4 py-1.5 rounded-full text-sm font-semibold transition active:scale-95 ${
                active
                  ? "bg-brand-600 text-white"
                  : "bg-gray-100 text-gray-700 hover:bg-gray-200"
              }`}
            >
              {label}
            </Link>
          );
        })}
      </div>

      {/* 지문 카드 */}
      {byPassage.size === 0 ? (
        <div className="bg-amber-50 border border-amber-200 rounded-xl p-8 text-center space-y-2">
          <div className="text-4xl">🌱</div>
          <p className="text-gray-700 font-semibold">
            아직 이 난이도에 직독직해 문장이 없어요
          </p>
          <p className="text-sm text-gray-500">
            강사가 문장을 추가하면 여기 표시됩니다. 다른 난이도 탭을 눌러보세요.
          </p>
        </div>
      ) : (
        <div className="space-y-6">
          {Array.from(byPassage.entries()).map(([pid, { title, difficulty, paragraphs }]) => (
            <div key={pid} className="bg-white border rounded-xl overflow-hidden shadow-sm">
              <div
                className={`h-1.5 bg-gradient-to-r ${TIER_COLOR[difficulty] ?? "from-gray-400 to-gray-500"}`}
              />
              <div className="p-4 sm:p-5">
                <div className="flex items-center gap-2 mb-3">
                  <span className="text-xs px-2 py-0.5 rounded-full bg-gray-100 text-gray-700 font-semibold">
                    {TIER_LABEL[difficulty] ?? difficulty}
                  </span>
                  <h3 className="font-bold text-gray-900">{title}</h3>
                </div>
                <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-2">
                  {paragraphs
                    .sort((a, b) => a.ord - b.ord)
                    .map((p) => {
                      const total = sentMap.get(p.id) ?? 0;
                      const a = attemptMap.get(p.id);
                      const done = !!a && a.total >= total && total > 0;
                      return (
                        <Link
                          key={p.id}
                          href={`/learn/chunks/${p.id}`}
                          className={`border-2 rounded-lg px-3 py-2.5 text-left transition active:scale-[0.99] ${
                            done
                              ? "border-emerald-200 bg-emerald-50 hover:border-emerald-300"
                              : "border-gray-200 hover:border-sky-300 hover:bg-sky-50"
                          }`}
                        >
                          <div className="text-xs font-semibold text-gray-500 mb-0.5">
                            단락 {p.ord + 1}
                          </div>
                          <div className="text-sm text-gray-800 line-clamp-2 leading-snug">
                            {p.body}
                          </div>
                          <div className="text-xs text-gray-500 mt-1.5">
                            문장 {total}개{" "}
                            {a && (
                              <span>
                                · 시도 {a.total}회{" "}
                                {a.good > 0 && (
                                  <span className="text-emerald-700 font-semibold">
                                    (익숙 {a.good})
                                  </span>
                                )}
                              </span>
                            )}
                          </div>
                        </Link>
                      );
                    })}
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
