import Link from "next/link";
import { createClient } from "@/lib/supabase/server";

export default async function PassagesPage() {
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
      <div>
        <h1 className="text-3xl font-bold">지문 라이브러리</h1>
        <p className="text-gray-500 mt-1">학습할 지문을 골라 한 권씩 끝내보세요.</p>
      </div>

      {(passages?.length ?? 0) === 0 && (
        <div className="text-center py-12 text-gray-400 bg-white border rounded-lg">
          아직 등록된 지문이 없습니다.
        </div>
      )}

      {(["low", "mid", "high", "elite"] as const).map((tier) => {
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
  low: "하 — 핵심 잡기",
  mid: "중 — 의미 추론",
  high: "상 — 복합 사고",
  elite: "극상 — 추상 추론",
};

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
              <Step label="1회독" done={progress.gist} total={paraCount} />
              <Step label="2회독" done={progress.structure} total={paraCount} />
              <Step label="3회독" done={progress.recon} total={paraCount} />
            </div>
          </div>
        )}
      </div>
    </Link>
  );
}

function Step({ label, done, total }: { label: string; done: number; total: number }) {
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
