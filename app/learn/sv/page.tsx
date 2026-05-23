import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";

type Tier = "all" | "low" | "mid" | "high" | "elite";
const TIER_LABEL: Record<string, string> = {
  all: "전체",
  low: "하",
  mid: "중",
  high: "상",
  elite: "극상",
};

export default async function SvLandingPage({
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

  // 난이도별 문장 수
  const { data: counts } = await supabase
    .from("te_sv_drill_sentences")
    .select("difficulty");
  const countMap = new Map<string, number>();
  for (const c of counts ?? []) {
    countMap.set(c.difficulty, (countMap.get(c.difficulty) ?? 0) + 1);
  }
  const totalAll = (counts ?? []).length;

  // 학생 통계
  const { data: attempts } = await supabase
    .from("te_sv_drill_attempts")
    .select("is_correct, kind")
    .eq("user_id", userId)
    .gte("attempted_at", new Date(Date.now() - 30 * 24 * 60 * 60 * 1000).toISOString());

  const total30d = attempts?.length ?? 0;
  const correct30d = attempts?.filter((a) => a.is_correct).length ?? 0;
  const accuracy = total30d > 0 ? Math.round((correct30d / total30d) * 100) : null;

  const tiers: Tier[] = ["all", "low", "mid", "high"];

  return (
    <div className="space-y-6">
      <div className="bg-gradient-to-r from-orange-500 to-amber-500 text-white rounded-2xl p-6 sm:p-8 shadow-md">
        <div className="text-xs font-semibold text-orange-50 mb-1">
          🔎 주어·동사 찾기
        </div>
        <h1 className="text-2xl sm:text-3xl font-bold leading-tight mb-2">
          복잡한 문장의 뼈대를 즉시 짚어내기
        </h1>
        <p className="text-orange-50 text-sm sm:text-base">
          문장이 길고 복잡할수록, 가장 먼저 주어와 동사를 잡아야 의미가 풀립니다.
          단어를 직접 탭해서 주어/동사를 빠르게 찾는 반사 훈련이에요.
        </p>
      </div>

      <div className="bg-white border rounded-xl p-4 sm:p-5 space-y-2">
        <h2 className="font-bold text-gray-900">이렇게 진행해요</h2>
        <ol className="text-sm text-gray-700 space-y-1 list-decimal pl-5">
          <li>화면 위에 "주어를 클릭" 또는 "동사를 클릭" 안내가 떠요</li>
          <li>문장 안의 단어를 직접 탭하세요 — 주어구의 어느 단어든 OK</li>
          <li>정답이면 초록, 오답이면 빨강 + 정답 자리가 함께 빛납니다</li>
          <li>10문장 한 세트, 끝나면 정답률·평균 시간이 나와요</li>
        </ol>
      </div>

      {/* 학생 통계 */}
      {total30d > 0 && (
        <div className="bg-gray-50 border rounded-xl p-4 grid grid-cols-3 gap-4 text-center">
          <div>
            <div className="text-xs text-gray-500">최근 30일 시도</div>
            <div className="text-xl font-bold text-gray-900">{total30d}</div>
          </div>
          <div>
            <div className="text-xs text-gray-500">정답률</div>
            <div className="text-xl font-bold text-emerald-700">
              {accuracy != null ? `${accuracy}%` : "—"}
            </div>
          </div>
          <div>
            <div className="text-xs text-gray-500">맞춘 개수</div>
            <div className="text-xl font-bold text-gray-900">{correct30d}</div>
          </div>
        </div>
      )}

      {/* 난이도 탭 */}
      <div className="flex flex-wrap gap-2">
        {tiers.map((t) => {
          const active = t === filterTier;
          const href = t === "all" ? "/learn/sv" : `/learn/sv?tier=${t}`;
          const count = t === "all" ? totalAll : countMap.get(t) ?? 0;
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
              {TIER_LABEL[t]}{count > 0 && <span className="ml-1 opacity-70">({count})</span>}
            </Link>
          );
        })}
      </div>

      {/* 시작 카드들 */}
      {totalAll === 0 ? (
        <div className="bg-amber-50 border border-amber-200 rounded-xl p-8 text-center space-y-2">
          <div className="text-4xl">🌱</div>
          <p className="text-gray-700 font-semibold">아직 등록된 문장이 없어요</p>
          <p className="text-sm text-gray-500">강사가 문장을 추가하면 여기서 훈련할 수 있어요.</p>
        </div>
      ) : (
        <div className="grid sm:grid-cols-2 gap-4">
          <Link
            href={`/learn/sv/play?tier=${filterTier}&count=10`}
            className="block bg-white border-2 border-orange-300 hover:border-orange-500 rounded-xl p-5 transition active:scale-[0.99] group"
          >
            <div className="text-3xl mb-2">⚡</div>
            <div className="font-bold text-gray-900 text-lg">빠른 10문장</div>
            <p className="text-sm text-gray-600 mt-1">한 세트 약 2~3분</p>
            <div className="text-sm font-semibold text-orange-600 mt-3 group-hover:underline">
              시작하기 →
            </div>
          </Link>
          <Link
            href={`/learn/sv/play?tier=${filterTier}&count=20`}
            className="block bg-white border-2 border-amber-300 hover:border-amber-500 rounded-xl p-5 transition active:scale-[0.99] group"
          >
            <div className="text-3xl mb-2">🏋️</div>
            <div className="font-bold text-gray-900 text-lg">집중 20문장</div>
            <p className="text-sm text-gray-600 mt-1">한 세트 약 5분</p>
            <div className="text-sm font-semibold text-amber-700 mt-3 group-hover:underline">
              시작하기 →
            </div>
          </Link>
        </div>
      )}
    </div>
  );
}
