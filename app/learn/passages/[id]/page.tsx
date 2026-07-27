import Link from "next/link";
import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";

export default async function PassageDetailPage({
  params,
}: {
  params: { id: string };
}) {
  const supabase = createClient();

  const { data: passage } = await supabase
    .from("te_passages")
    .select("id, title, source, grade_level, difficulty, body, te_paragraphs(id, ord, body)")
    .eq("id", params.id)
    .maybeSingle();

  if (!passage) notFound();

  const te_paragraphs = (passage.te_paragraphs ?? []).sort(
    (a: any, b: any) => a.ord - b.ord,
  );
  const paragraphIds = te_paragraphs.map((p: any) => p.id);

  const { data: userResp } = await supabase.auth.getUser();
  const userId = userResp.user!.id;

  const { data: gistNotes } = await supabase
    .from("te_gist_notes")
    .select(
      "paragraph_id, main_idea_text, supporting_text, structure_notes, structure_done_at",
    )
    .eq("user_id", userId)
    .in("paragraph_id", paragraphIds);

  const notesByPara = new Map<
    string,
    { hasGist: boolean; hasStructure: boolean }
  >();
  for (const n of gistNotes ?? []) {
    notesByPara.set(n.paragraph_id, {
      hasGist: !!n.main_idea_text && !!n.supporting_text,
      hasStructure: !!n.structure_done_at,
    });
  }

  const { data: attempts } = await supabase
    .from("te_reconstruction_attempts")
    .select("paragraph_id, ai_score, created_at")
    .eq("user_id", userId)
    .in("paragraph_id", paragraphIds)
    .order("created_at", { ascending: false });

  const lastAttemptByPara = new Map<string, number | null>();
  for (const a of attempts ?? []) {
    if (!lastAttemptByPara.has(a.paragraph_id)) {
      lastAttemptByPara.set(a.paragraph_id, a.ai_score);
    }
  }

  // 직독직해 청크 문장 존재 여부
  const { data: chunkRows } = await supabase
    .from("te_chunk_sentences")
    .select("paragraph_id")
    .in("paragraph_id", paragraphIds);
  const hasChunkByPara = new Set<string>((chunkRows ?? []).map((r) => r.paragraph_id));

  // 주어·동사 문장 / 이 지문 문제 존재 여부
  const [{ data: svRows }, { data: questionRows }] = await Promise.all([
    supabase.from("te_sv_drill_sentences").select("id").eq("passage_id", passage.id),
    supabase.from("te_questions").select("id").eq("passage_id", passage.id),
  ]);
  const hasSv = (svRows ?? []).length > 0;
  const questionCount = (questionRows ?? []).length;

  const totalPara = te_paragraphs.length || 1;
  const pass1Done = te_paragraphs.filter((p: any) => notesByPara.get(p.id)?.hasGist).length;
  const pass2Done = te_paragraphs.filter((p: any) => notesByPara.get(p.id)?.hasStructure).length;
  const pass3Done = te_paragraphs.filter((p: any) => lastAttemptByPara.has(p.id)).length;

  const tier = (passage.difficulty as string) ?? "none";
  const tierMeta = TIER_META[tier] ?? TIER_META.none;
  const grade = passage.grade_level
    ? passage.grade_level <= 9
      ? `중${passage.grade_level - 6}`
      : `고${passage.grade_level - 9}`
    : null;

  return (
    <div className="space-y-6">
      <div>
        <Link
          href="/learn/passages"
          className="text-sm text-gray-500 hover:text-gray-900"
        >
          ← 지문 라이브러리
        </Link>
      </div>

      {/* 책 표지 — 지문 헤더 */}
      <div className={`rounded-2xl overflow-hidden shadow-md ${tierMeta.cover}`}>
        <div className={`h-2 ${tierMeta.band}`} />
        <div className="p-6 sm:p-8 space-y-3">
          <div className="flex items-center gap-2 text-xs">
            <span className={`px-2 py-0.5 rounded-full bg-white/70 ${tierMeta.text} font-semibold`}>
              {tierMeta.label}
            </span>
            {grade && (
              <span className="px-2 py-0.5 rounded-full bg-white/70 text-gray-700">{grade}</span>
            )}
            {passage.source && (
              <span className="text-gray-600">· {passage.source}</span>
            )}
          </div>
          <h1 className="text-2xl sm:text-3xl font-bold text-gray-900 leading-tight">
            {passage.title}
          </h1>
          <p className="text-gray-700 text-sm sm:text-base leading-relaxed">
            {passage.body}
          </p>
        </div>
      </div>

      {/* 3회독 진척 */}
      <div className="bg-white border rounded-xl p-5 sm:p-6 shadow-sm">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-base font-semibold text-gray-800">진척</h2>
          <span className="text-xs text-gray-500">단락 {totalPara}개</span>
        </div>
        <div className="grid grid-cols-3 gap-4">
          <RoundCell label="핵심 문장" done={pass1Done} total={totalPara} color="bg-amber-500" />
          <RoundCell
            label="문장 구조"
            done={pass2Done}
            total={totalPara}
            color="bg-sky-500"
          />
          <RoundCell label="재구성" done={pass3Done} total={totalPara} color="bg-blue-600" />
        </div>
      </div>

      {/* 단락 카드 */}
      <div className="space-y-3">
        <h2 className="text-xl font-bold text-gray-900">단락별 학습</h2>
        {te_paragraphs.map((p: any, i: number) => {
          const note = notesByPara.get(p.id);
          const hasGist = note?.hasGist ?? false;
          const hasStructure = note?.hasStructure ?? false;
          const score = lastAttemptByPara.get(p.id);
          const hasRecon = typeof score === "number";
          const hasChunks = hasChunkByPara.has(p.id);

          return (
            <div
              key={p.id}
              className="bg-white border rounded-xl shadow-sm overflow-hidden hover:shadow-md transition"
            >
              <div className="p-5 sm:p-6 space-y-4">
                {/* 단락 헤더 */}
                <div className="flex items-center justify-between gap-3 flex-wrap">
                  <div className="flex items-center gap-2">
                    <span className="text-xs font-bold text-gray-400">단락 {i + 1}</span>
                    <span className="text-gray-300">·</span>
                    <StepBadge label="1회독" done={hasGist} color="amber" />
                    <StepBadge label="2회독" done={hasStructure} color="sky" />
                    <StepBadge
                      label={hasRecon ? `${score}점` : "3회독"}
                      done={hasRecon}
                      color="blue"
                    />
                  </div>
                </div>

                {/* 단락 본문 미리보기 */}
                <p className="text-gray-700 leading-relaxed line-clamp-3 text-sm sm:text-base">
                  {p.body}
                </p>

                {/* 버튼 — 학습 순서대로 */}
                <div className="flex flex-wrap gap-2 pt-1">
                  <Link
                    href={`/learn/paragraphs/${p.id}/gist`}
                    className={`inline-flex items-center gap-1.5 text-sm px-3.5 py-2 rounded-lg font-semibold transition ${
                      hasGist
                        ? "bg-amber-100 text-amber-800 hover:bg-amber-200"
                        : "bg-amber-500 text-white hover:bg-amber-600"
                    }`}
                  >
                    {hasGist ? "✓ 1 핵심 문장" : "1 핵심 문장 찾기"}
                  </Link>
                  {hasGist && hasSv && (
                    <Link
                      href={`/learn/sv/play?passage=${passage.id}&from=${p.id}`}
                      className="inline-flex items-center gap-1.5 text-sm px-3.5 py-2 rounded-lg font-semibold bg-orange-500 text-white hover:bg-orange-600 transition"
                    >
                      🔎 주어·동사
                    </Link>
                  )}
                  {hasGist && hasChunks && (
                    <Link
                      href={`/learn/chunks/${p.id}`}
                      className="inline-flex items-center gap-1.5 text-sm px-3.5 py-2 rounded-lg font-semibold bg-purple-500 text-white hover:bg-purple-600 transition"
                    >
                      📝 직독직해
                    </Link>
                  )}
                  {hasGist && (
                    <Link
                      href={`/learn/paragraphs/${p.id}/structure`}
                      className={`inline-flex items-center gap-1.5 text-sm px-3.5 py-2 rounded-lg font-semibold transition ${
                        hasStructure
                          ? "bg-sky-100 text-sky-800 hover:bg-sky-200"
                          : "bg-sky-500 text-white hover:bg-sky-600"
                      }`}
                    >
                      {hasStructure ? "✓ 문장 구조" : "🧱 문장 구조"}
                    </Link>
                  )}
                  {hasGist && (
                    <Link
                      href={`/learn/paragraphs/${p.id}/reconstruct`}
                      className={`inline-flex items-center gap-1.5 text-sm px-3.5 py-2 rounded-lg font-semibold transition ${
                        hasRecon
                          ? "bg-blue-100 text-blue-800 hover:bg-blue-200"
                          : "bg-blue-600 text-white hover:bg-blue-700"
                      }`}
                    >
                      {hasRecon ? "✓ 재구성" : "🧠 재구성"}
                    </Link>
                  )}
                </div>
              </div>
            </div>
          );
        })}
      </div>

      {/* 마지막 단계 — 이 지문으로 문제 풀기 */}
      {questionCount > 0 && (
        <Link
          href={`/learn/passages/${passage.id}/quiz`}
          className="block rounded-2xl bg-gradient-to-r from-sky-500 to-blue-700 text-white p-6 shadow-md hover:shadow-lg active:scale-[0.99] transition"
        >
          <div className="text-xs font-semibold text-sky-100 mb-1">🎯 마지막 단계</div>
          <div className="text-xl font-bold">이 지문 문제 {questionCount}개 풀기 →</div>
          <p className="text-sky-50 text-sm mt-1">
            새 지문이 아니라, 방금 읽은 이 지문에서 나온 문제만 풉니다.
          </p>
        </Link>
      )}
    </div>
  );
}

const TIER_META: Record<
  string,
  { cover: string; band: string; text: string; label: string }
> = {
  low: {
    cover: "bg-gradient-to-br from-emerald-50 to-green-100",
    band: "bg-gradient-to-r from-emerald-400 to-green-500",
    text: "text-emerald-800",
    label: "하",
  },
  mid: {
    cover: "bg-gradient-to-br from-amber-50 to-yellow-100",
    band: "bg-gradient-to-r from-amber-400 to-yellow-500",
    text: "text-amber-800",
    label: "중",
  },
  high: {
    cover: "bg-gradient-to-br from-orange-50 to-orange-100",
    band: "bg-gradient-to-r from-orange-400 to-orange-600",
    text: "text-orange-800",
    label: "상",
  },
  elite: {
    cover: "bg-gradient-to-br from-rose-50 to-red-100",
    band: "bg-gradient-to-r from-rose-500 to-red-600",
    text: "text-rose-800",
    label: "극상",
  },
  none: {
    cover: "bg-gradient-to-br from-gray-50 to-gray-100",
    band: "bg-gradient-to-r from-gray-300 to-gray-400",
    text: "text-gray-700",
    label: "기본",
  },
};

function RoundCell({
  label,
  done,
  total,
  color,
}: {
  label: string;
  done: number;
  total: number;
  color: string;
}) {
  const pct = total > 0 ? Math.round((done / total) * 100) : 0;
  return (
    <div>
      <div className="flex items-center justify-between text-xs text-gray-600 mb-1">
        <span className="font-medium">{label}</span>
        <span className="text-gray-700">
          {done} / {total}
        </span>
      </div>
      <div className="w-full h-2 bg-gray-100 rounded-full overflow-hidden">
        <div className={`h-full ${color} transition-all`} style={{ width: `${pct}%` }} />
      </div>
    </div>
  );
}

function StepBadge({
  label,
  done,
  color,
}: {
  label: string;
  done: boolean;
  color: "amber" | "sky" | "blue";
}) {
  const cls = done
    ? color === "amber"
      ? "bg-amber-500 text-white"
      : color === "sky"
        ? "bg-sky-500 text-white"
        : "bg-blue-600 text-white"
    : "bg-gray-100 text-gray-400";
  return (
    <span className={`text-[10px] sm:text-xs px-2 py-0.5 rounded-full font-semibold ${cls}`}>
      {label}
    </span>
  );
}
