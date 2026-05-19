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
    {
      hasGist: boolean;
      hasStructure: boolean;
    }
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

  // 지문 전체 회독 진척 계산
  const totalPara = te_paragraphs.length || 1;
  const pass1Done = te_paragraphs.filter((p: any) => notesByPara.get(p.id)?.hasGist).length;
  const pass2Done = te_paragraphs.filter((p: any) => notesByPara.get(p.id)?.hasStructure).length;
  const pass3Done = te_paragraphs.filter((p: any) => lastAttemptByPara.has(p.id)).length;

  return (
    <div className="space-y-6">
      <div>
        <Link
          href="/learn/passages"
          className="text-sm text-gray-500 hover:text-gray-900"
        >
          ← 지문 목록
        </Link>
        <h1 className="text-3xl font-bold mt-2">{passage.title}</h1>
        <p className="text-gray-500 mt-1">
          {passage.source && `${passage.source} · `}단락 {te_paragraphs.length}개
        </p>
      </div>

      {/* 3회독 진척 요약 */}
      <div className="bg-white border rounded-lg p-5">
        <div className="text-sm font-medium text-gray-700 mb-3">3회독 진척</div>
        <div className="grid grid-cols-3 gap-3">
          <RoundCell label="1회독 · Gist" done={pass1Done} total={totalPara} color="bg-amber-500" />
          <RoundCell label="2회독 · Structure" done={pass2Done} total={totalPara} color="bg-sky-500" />
          <RoundCell label="3회독 · 재구성" done={pass3Done} total={totalPara} color="bg-blue-600" />
        </div>
      </div>

      <div className="space-y-3">
        {te_paragraphs.map((p: any, i: number) => {
          const note = notesByPara.get(p.id);
          const hasGist = note?.hasGist ?? false;
          const hasStructure = note?.hasStructure ?? false;
          const score = lastAttemptByPara.get(p.id);
          const hasRecon = typeof score === "number";

          return (
            <div key={p.id} className="bg-white border rounded-lg p-5">
              <div className="flex items-center justify-between mb-3">
                <div className="flex items-center gap-2">
                  <span className="text-sm font-medium text-gray-500">
                    단락 {i + 1}
                  </span>
                  <StepBadge label="Gist" done={hasGist} color="amber" />
                  <StepBadge label="Structure" done={hasStructure} color="sky" />
                  <StepBadge
                    label={hasRecon ? `재구성 ${score}점` : "재구성"}
                    done={hasRecon}
                    color="blue"
                  />
                </div>
                <div className="flex gap-2">
                  <Link
                    href={`/learn/paragraphs/${p.id}/gist`}
                    className={`text-sm px-3 py-1.5 rounded-md text-white ${
                      hasGist
                        ? "bg-amber-500 hover:bg-amber-600"
                        : "bg-brand-600 hover:bg-brand-700"
                    }`}
                  >
                    {hasGist ? "1회독 다시" : "1회독 시작"}
                  </Link>
                  {hasGist && (
                    <Link
                      href={`/learn/paragraphs/${p.id}/structure`}
                      className={`text-sm px-3 py-1.5 rounded-md text-white ${
                        hasStructure
                          ? "bg-sky-500 hover:bg-sky-600"
                          : "bg-sky-600 hover:bg-sky-700"
                      }`}
                    >
                      {hasStructure ? "2회독 다시" : "2회독"}
                    </Link>
                  )}
                  {hasGist && (
                    <Link
                      href={`/learn/paragraphs/${p.id}/reconstruct`}
                      className="text-sm px-3 py-1.5 rounded-md bg-accent-600 text-white hover:bg-accent-500"
                    >
                      {hasRecon ? "3회독 다시" : "3회독"}
                    </Link>
                  )}
                </div>
              </div>
              <p className="text-gray-700 leading-relaxed line-clamp-2">{p.body}</p>
            </div>
          );
        })}
      </div>
    </div>
  );
}

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
        <span>{label}</span>
        <span>
          {done} / {total}
        </span>
      </div>
      <div className="w-full h-2 bg-gray-100 rounded-full overflow-hidden">
        <div className={`h-full ${color}`} style={{ width: `${pct}%` }} />
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
      ? "bg-amber-100 text-amber-800"
      : color === "sky"
        ? "bg-sky-100 text-sky-800"
        : "bg-blue-100 text-blue-800"
    : "bg-gray-100 text-gray-400";
  return (
    <span className={`text-xs px-2 py-0.5 rounded-full font-medium ${cls}`}>
      {done ? "✓ " : ""}
      {label}
    </span>
  );
}
