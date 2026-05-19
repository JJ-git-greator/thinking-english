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
    .select("paragraph_id, main_idea_text, supporting_text")
    .eq("user_id", userId)
    .in("paragraph_id", paragraphIds);

  const notesByPara = new Map<string, { hasMain: boolean; hasSupport: boolean }>();
  for (const n of gistNotes ?? []) {
    notesByPara.set(n.paragraph_id, {
      hasMain: !!n.main_idea_text,
      hasSupport: !!n.supporting_text,
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

      <div className="space-y-3">
        {te_paragraphs.map((p: any, i: number) => {
          const note = notesByPara.get(p.id);
          const score = lastAttemptByPara.get(p.id);
          return (
            <div key={p.id} className="bg-white border rounded-lg p-5">
              <div className="flex items-center justify-between mb-3">
                <div className="flex items-center gap-2">
                  <span className="text-sm font-medium text-gray-500">
                    단락 {i + 1}
                  </span>
                  {note?.hasMain && note?.hasSupport && (
                    <span className="text-xs px-2 py-0.5 rounded-full bg-brand-100 text-brand-800">
                      Gist 완료
                    </span>
                  )}
                  {typeof score === "number" && (
                    <span className="text-xs px-2 py-0.5 rounded-full bg-blue-100 text-blue-800">
                      재구성 {score}점
                    </span>
                  )}
                </div>
                <div className="flex gap-2">
                  <Link
                    href={`/learn/paragraphs/${p.id}/gist`}
                    className="text-sm px-3 py-1.5 rounded-md bg-brand-600 text-white hover:bg-brand-700"
                  >
                    {note?.hasMain && note?.hasSupport ? "Gist 다시 보기" : "Gist 시작"}
                  </Link>
                  {note?.hasMain && note?.hasSupport && (
                    <Link
                      href={`/learn/paragraphs/${p.id}/reconstruct`}
                      className="text-sm px-3 py-1.5 rounded-md bg-accent-600 text-white hover:bg-accent-500"
                    >
                      재구성
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
