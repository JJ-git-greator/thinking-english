import Link from "next/link";
import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import GistWorkspace from "./GistWorkspace";
import LearningFlow from "@/components/LearningFlow";

export default async function GistPage({ params }: { params: { id: string } }) {
  const supabase = createClient();

  const { data: paragraph } = await supabase
    .from("te_paragraphs")
    .select("id, ord, body, passage_id, te_passages(id, title)")
    .eq("id", params.id)
    .maybeSingle();

  if (!paragraph) notFound();

  const { data: userResp } = await supabase.auth.getUser();
  const userId = userResp.user!.id;

  const { data: existing } = await supabase
    .from("te_gist_notes")
    .select(
      "main_idea_text, supporting_text, main_idea_offset, supporting_offset, main_reasoning, supporting_reasoning, ai_evaluation",
    )
    .eq("user_id", userId)
    .eq("paragraph_id", paragraph.id)
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

      <div className="bg-gradient-to-r from-amber-500 to-yellow-500 text-white rounded-2xl p-6 sm:p-7 shadow-md">
        <div className="flex items-center justify-between mb-1 gap-3 flex-wrap">
          <div className="text-xs font-semibold text-amber-50">📖 단락 깊이 읽기 · 1/3단계 (Gist)</div>
          <div className="hidden sm:flex items-center gap-1 text-xs text-white/80">
            <span className="px-2 py-0.5 rounded-full bg-white/20 font-bold">1회독</span>
            <span>→</span>
            <span className="px-2 py-0.5 rounded-full bg-white/10">2회독</span>
            <span>→</span>
            <span className="px-2 py-0.5 rounded-full bg-white/10">3회독</span>
          </div>
        </div>
        <h1 className="text-2xl sm:text-3xl font-bold leading-tight">
          단락 {paragraph.ord + 1} — 핵심 두 문장 찾기
        </h1>
        <p className="text-amber-50 mt-2 text-sm sm:text-base">
          이 단락의 <b className="text-white">메인 아이디어</b> 한 문장과 그것을 받쳐주는{" "}
          <b className="text-white">서포팅 센텐스</b> 한 문장을 골라보세요. 문장을 클릭해서
          표시합니다.
        </p>
      </div>

      <GistWorkspace paragraphId={paragraph.id} body={paragraph.body} initial={existing ?? null} />
    </div>
  );
}
