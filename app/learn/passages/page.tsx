import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import LearningFlow from "@/components/LearningFlow";

type Tier = "all" | "low" | "mid" | "high" | "elite";

export default async function PassagesPage({
  searchParams,
}: {
  searchParams?: { tier?: string };
}) {
  const filterTier: Tier = (["all", "low", "mid", "high", "elite"] as Tier[]).includes(
    searchParams?.tier as Tier,
  )
    ? (searchParams!.tier as Tier)
    : "all";

  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  const userId = userResp.user?.id;

  const { data: passages } = await supabase
    .from("te_passages")
    .select("id, title, source, grade_level, difficulty, te_paragraphs(id)")
    .order("grade_level", { ascending: true });

  // 학생 진척 한 번에 조회
  const allParaIds =
    passages?.flatMap((p: any) => (p.te_paragraphs ?? []).map((pa: any) => pa.id)) ?? [];
  const paraToPassage = new Map<string, string>();
  for (const p of passages ?? []) {
    for (const pa of (p as any).te_paragraphs ?? []) {
      paraToPassage.set(pa.id, p.id);
    }
  }

  const { data: gists } = userId
    ? await supabase
        .from("te_gist_notes")
        .select("paragraph_id, structure_done_at")
        .eq("user_id", userId)
        .in("paragraph_id", allParaIds.length ? allParaIds : ["00000000-0000-0000-0000-000000000000"])
    : { data: [] };
  const { data: recons } = userId
    ? await supabase
        .from("te_reconstruction_attempts")
        .select("paragraph_id")
        .eq("user_id", userId)
        .in("paragraph_id", allParaIds.length ? allParaIds : ["00000000-0000-0000-0000-000000000000"])
    : { data: [] };

  // 지문별 카운트 집계
  const stats = new Map<string, { gist: number; structure: number; recon: number }>();
  for (const g of gists ?? []) {
    const pid = paraToPassage.get(g.paragraph_id);
    if (!pid) continue;
    const cur = stats.get(pid) ?? { gist: 0, structure: 0, recon: 0 };
    cur.gist++;
    if (g.structure_done_at) cur.structure++;
    stats.set(pid, cur);
  }
  const seenReconPara = new Set<string>();
  for (const r of recons ?? []) {
    if (seenReconPara.has(r.paragraph_id)) continue;
    seenReconPara.add(r.paragraph_id);
    const pid = paraToPassage.get(r.paragraph_id);
    if (!pid) continue;
    const cur = stats.get(pid) ?? { gist: 0, structure: 0, recon: 0 };
    cur.recon++;
    stats.set(pid, cur);
  }

  // 난이도별 그룹화
  const groups = {
    low: [] as any[],
    mid: [] as any[],
    high: [] as any[],
    elite: [] as any[],
    none: [] as any[],
  };
  for (const p of passages ?? []) {
    const tier = (p.difficulty as keyof typeof groups) ?? "none";
    (groups[tier] ?? groups.none).push(p);
  }

  return (
    <div className="space-y-8">
      {/* 히어로 헤더 */}
      <div className="relative overflow-hidden rounded-2xl bg-gradient-to-br from-amber-500 to-yellow-600 text-white p-7 sm:p-9 shadow-md">
        <div className="absolute inset-0 opacity-10 bg-[radial-gradient(circle_at_80%_30%,white,transparent_50%)]" />
        <div className="relative space-y-3">
          <div className="text-sm text-amber-100">📖 단락 깊이 읽기</div>
          <h1 className="text-3xl sm:text-4xl font-bold leading-tight">
            한 단락을 끝까지 파고드세요
          </h1>
          <p className="text-amber-50 text-sm sm:text-base max-w-2xl">
            영어 단락 한 편을 <b className="text-white">3번 다른 각도</b>로 읽습니다.
            메모리가 아니라 진짜 이해를 만들기 위한 메인 학습이에요.
          </p>
        </div>
      </div>

      {/* 학습 흐름 */}
      <LearningFlow current="deep" />

      {/* 절차 안내 */}
      <div className="bg-amber-50 border border-amber-200 rounded-xl p-5 sm:p-6">
        <div className="text-sm font-bold text-amber-900 mb-3">한 단락을 어떻게 학습하나요?</div>
        <div className="space-y-2 text-sm text-gray-700">
          <Step num={1} title="1회독 · Gist" desc="단락에서 핵심 두 문장(메인+서포팅)을 클릭으로 고르세요. 선택 적합도를 즉시 검토해줍니다." />
          <Step num={2} title="2회독 · Structure" desc="이 단락의 영어 구조·어법 포인트를 한국어로 메모합니다." />
          <Step num={3} title="3회독 · 재구성" desc="원문을 가린 채 두 문장만 보고 단락 전체를 한국어로 재구성합니다. 첨삭과 코칭이 따라옵니다."/>
        </div>
        <p className="text-xs text-amber-800 mt-3">
          ⏱ 한 단락당 10~15분. 완료한 단락은 며칠 뒤 <b>오늘의 복습</b>에 자동으로 다시 등장합니다.
        </p>
      </div>

      {/* 난이도 필터 탭 */}
      <div className="flex gap-1 overflow-x-auto -mx-1 px-1 pb-1">
        <TierTab tier="all" active={filterTier === "all"} count={passages?.length ?? 0} />
        <TierTab tier="low" active={filterTier === "low"} count={groups.low.length} />
        <TierTab tier="mid" active={filterTier === "mid"} count={groups.mid.length} />
        <TierTab tier="high" active={filterTier === "high"} count={groups.high.length} />
        <TierTab tier="elite" active={filterTier === "elite"} count={groups.elite.length} />
      </div>

      {(passages?.length ?? 0) === 0 && (
        <div className="text-center py-12 text-gray-400 bg-white border rounded-lg">
          아직 등록된 지문이 없습니다.
        </div>
      )}

      {filterTier !== "all" && groups[filterTier].length === 0 && (
        <div className="text-center py-12 text-gray-400 bg-white border border-dashed rounded-lg">
          {TIER_TITLES[filterTier]} 난이도에 등록된 지문이 아직 없어요.
        </div>
      )}

      {(["low", "mid", "high", "elite"] as const)
        .filter((tier) => filterTier === "all" || filterTier === tier)
        .map((tier) => {
        const group = groups[tier];
        if (group.length === 0) return null;
        return (
          <section key={tier} className="space-y-3">
            <div className="flex items-baseline gap-3">
              <h2 className="text-xl font-semibold text-gray-800">
                {TIER_TITLES[tier]}
              </h2>
              <span className="text-sm text-gray-400">{group.length}권</span>
            </div>
            <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
              {group.map((p: any) => (
                <BookCard
                  key={p.id}
                  passage={p}
                  paraCount={(p.te_paragraphs ?? []).length}
                  progress={stats.get(p.id) ?? { gist: 0, structure: 0, recon: 0 }}
                />
              ))}
            </div>
          </section>
        );
      })}
    </div>
  );
}

const TIER_TITLES: Record<string, string> = {
  all: "전체",
  low: "하 — 핵심 잡기",
  mid: "중 — 의미 추론",
  high: "상 — 복합 사고",
  elite: "극상 — 추상 추론",
};

const TIER_SHORT: Record<string, string> = {
  all: "전체",
  low: "하",
  mid: "중",
  high: "상",
  elite: "극상",
};

const TIER_TAB_COLOR: Record<string, string> = {
  all: "bg-gray-900 text-white",
  low: "bg-emerald-500 text-white",
  mid: "bg-amber-500 text-white",
  high: "bg-orange-500 text-white",
  elite: "bg-rose-500 text-white",
};

function Step({ num, title, desc }: { num: number; title: string; desc: string }) {
  return (
    <div className="flex gap-3">
      <div className="shrink-0 w-7 h-7 rounded-full bg-amber-500 text-white text-sm font-bold flex items-center justify-center">
        {num}
      </div>
      <div className="flex-1">
        <span className="font-semibold text-gray-900">{title}</span>
        <span className="text-gray-600"> — {desc}</span>
      </div>
    </div>
  );
}

function TierTab({
  tier,
  active,
  count,
}: {
  tier: string;
  active: boolean;
  count: number;
}) {
  return (
    <Link
      href={tier === "all" ? "/learn/passages" : `/learn/passages?tier=${tier}`}
      className={`shrink-0 inline-flex items-center gap-1.5 px-4 py-2 rounded-full text-sm font-semibold transition ${
        active
          ? TIER_TAB_COLOR[tier]
          : "bg-white border border-gray-200 text-gray-600 hover:border-gray-300"
      }`}
    >
      {TIER_SHORT[tier]}
      <span
        className={`text-xs px-1.5 py-0.5 rounded-full ${
          active ? "bg-white/20" : "bg-gray-100 text-gray-500"
        }`}
      >
        {count}
      </span>
    </Link>
  );
}

const TIER_COLORS: Record<string, { band: string; bg: string; ring: string; text: string }> = {
  low: {
    band: "bg-gradient-to-r from-emerald-400 to-green-500",
    bg: "bg-emerald-50",
    ring: "hover:ring-emerald-300",
    text: "text-emerald-800",
  },
  mid: {
    band: "bg-gradient-to-r from-amber-400 to-yellow-500",
    bg: "bg-amber-50",
    ring: "hover:ring-amber-300",
    text: "text-amber-800",
  },
  high: {
    band: "bg-gradient-to-r from-orange-400 to-orange-600",
    bg: "bg-orange-50",
    ring: "hover:ring-orange-300",
    text: "text-orange-800",
  },
  elite: {
    band: "bg-gradient-to-r from-rose-500 to-red-600",
    bg: "bg-rose-50",
    ring: "hover:ring-rose-300",
    text: "text-rose-800",
  },
  none: {
    band: "bg-gradient-to-r from-gray-300 to-gray-400",
    bg: "bg-gray-50",
    ring: "hover:ring-gray-300",
    text: "text-gray-700",
  },
};

const TIER_LABEL: Record<string, string> = {
  low: "하",
  mid: "중",
  high: "상",
  elite: "극상",
};

function BookCard({
  passage,
  paraCount,
  progress,
}: {
  passage: any;
  paraCount: number;
  progress: { gist: number; structure: number; recon: number };
}) {
  const tier = (passage.difficulty as string) ?? "none";
  const c = TIER_COLORS[tier] ?? TIER_COLORS.none;
  const grade = passage.grade_level
    ? passage.grade_level <= 9
      ? `중${passage.grade_level - 6}`
      : `고${passage.grade_level - 9}`
    : null;

  const completed = progress.recon; // 완전 학습 사이클 통과 단락 수 기준
  const pct = paraCount > 0 ? Math.round((completed / paraCount) * 100) : 0;

  return (
    <Link
      href={`/learn/passages/${passage.id}`}
      className={`group relative block bg-white rounded-xl overflow-hidden border ring-1 ring-transparent ${c.ring} hover:ring-2 hover:-translate-y-0.5 hover:shadow-lg transition-all duration-150 shadow-sm`}
    >
      {/* 책 등 — 상단 색 띠 */}
      <div className={`h-1.5 ${c.band}`} />

      <div className={`p-5 space-y-3 ${c.bg}`}>
        {/* 난이도 뱃지 + 학년 */}
        <div className="flex items-center justify-between">
          <span className={`inline-flex items-center gap-1 text-xs font-semibold ${c.text}`}>
            <span className={`w-1.5 h-1.5 rounded-full ${c.band}`} />
            {TIER_LABEL[tier] ?? "기본"}
          </span>
          {grade && <span className="text-xs text-gray-500">{grade}</span>}
        </div>

        {/* 제목 */}
        <h3 className="font-bold text-gray-900 leading-snug line-clamp-2 min-h-[2.5rem]">
          {passage.title}
        </h3>

        {/* 출처·단락 수 */}
        <div className="flex items-center justify-between text-xs text-gray-500">
          {passage.source ? (
            <span className="truncate max-w-[60%]">{passage.source}</span>
          ) : (
            <span />
          )}
          <span>📄 {paraCount}단락</span>
        </div>

        {/* 학생 진척 */}
        {paraCount > 0 && (
          <div className="space-y-1.5 pt-1">
            <div className="flex items-center justify-between text-xs">
              <span className="text-gray-500">학습 진척</span>
              <span className="font-semibold text-gray-700">
                {pct}%
              </span>
            </div>
            <div className="w-full h-1.5 bg-white/70 rounded-full overflow-hidden">
              <div
                className={`h-full ${c.band} transition-all`}
                style={{ width: `${pct}%` }}
              />
            </div>
            <div className="flex gap-2 text-[10px] text-gray-500 pt-0.5">
              <StepBar label="1회독" done={progress.gist} total={paraCount} />
              <StepBar label="2회독" done={progress.structure} total={paraCount} />
              <StepBar label="3회독" done={progress.recon} total={paraCount} />
            </div>
          </div>
        )}
      </div>
    </Link>
  );
}

function StepBar({ label, done, total }: { label: string; done: number; total: number }) {
  const full = done >= total && total > 0;
  return (
    <span
      className={`px-1.5 py-0.5 rounded ${
        full
          ? "bg-brand-600 text-white"
          : done > 0
            ? "bg-white text-gray-700 border border-gray-200"
            : "bg-gray-100 text-gray-400"
      }`}
    >
      {label} {done}/{total}
    </span>
  );
}
