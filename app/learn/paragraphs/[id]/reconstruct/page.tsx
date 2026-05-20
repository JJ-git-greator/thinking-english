import Link from "next/link";
import { notFound, redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import ReconstructWorkspace from "./ReconstructWorkspace";

export default async function ReconstructPage({
  params,
}: {
  params: { id: string };
}) {
  const supabase = createClient();

  const { data: paragraph } = await supabase
    .from("te_paragraphs")
    .select("id, ord, body, passage_id, te_passages(id, title)")
    .eq("id", params.id)
    .maybeSingle();

  if (!paragraph) notFound();

  const { data: userResp } = await supabase.auth.getUser();
  const userId = userResp.user!.id;

  const { data: gist } = await supabase
    .from("te_gist_notes")
    .select("main_idea_text, supporting_text")
    .eq("user_id", userId)
    .eq("paragraph_id", paragraph.id)
    .maybeSingle();

  if (!gist?.main_idea_text || !gist?.supporting_text) {
    redirect(`/learn/paragraphs/${paragraph.id}/gist`);
  }

  const { data: latest } = await supabase
    .from("te_reconstruction_attempts")
    .select("id, ai_score, ai_subscores, ai_feedback, student_text, created_at")
    .eq("user_id", userId)
    .eq("paragraph_id", paragraph.id)
    .order("created_at", { ascending: false })
    .limit(1)
    .maybeSingle();

  const passage = Array.isArray(paragraph.te_passages)
    ? paragraph.te_passages[0]
    : paragraph.te_passages;

  return (
    <div className="space-y-6">
      <Link
        href={`/learn/passages/${passage?.id}`}
        className="inline-flex items-center text-sm text-gray-500 hover:text-gray-900"
      >
        ← {passage?.title}
      </Link>

      <div className="bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-2xl p-6 sm:p-7 shadow-md">
        <div className="flex items-center justify-between mb-1 gap-3 flex-wrap">
          <div className="text-xs font-semibold text-blue-50">📖 단락 깊이 읽기 · 3/3단계 (재구성)</div>
          <div className="hidden sm:flex items-center gap-1 text-xs text-white/80">
            <span className="px-2 py-0.5 rounded-full bg-white/10">1회독 ✓</span>
            <span>→</span>
            <span className="px-2 py-0.5 rounded-full bg-white/10">2회독 ✓</span>
            <span>→</span>
            <span className="px-2 py-0.5 rounded-full bg-white/20 font-bold">3회독</span>
          </div>
        </div>
        <h1 className="text-2xl sm:text-3xl font-bold leading-tight">
          단락 {paragraph.ord + 1} — 핵심에서 전체로
        </h1>
        <p className="text-blue-50 mt-2 text-sm sm:text-base">
          본문은 가려집니다. 아래 두 문장만 보고, 단락 전체 내용을{" "}
          <b className="text-white">한국어로 자기 말로 풀어써 보세요</b>. 영어 작문이 아니라
          이해 점검입니다. 첨삭과 코칭이 따라오고, 완료하면 며칠 후 자동으로 복습에
          등장합니다.
        </p>
      </div>

      <ReconstructWorkspace
        paragraphId={paragraph.id}
        paragraphBody={paragraph.body}
        gist={{
          mainIdea: gist.main_idea_text!,
          supporting: gist.supporting_text!,
        }}
        latest={latest}
      />
    </div>
  );
}
