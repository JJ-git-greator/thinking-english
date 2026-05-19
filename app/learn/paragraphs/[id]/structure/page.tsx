import Link from "next/link";
import { notFound, redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import StructureWorkspace from "./StructureWorkspace";

export default async function StructurePage({
  params,
}: {
  params: { id: string };
}) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) redirect("/login");
  const userId = userResp.user.id;

  const { data: paragraph } = await supabase
    .from("te_paragraphs")
    .select("id, ord, body, passage_id, te_passages(id, title)")
    .eq("id", params.id)
    .maybeSingle();

  if (!paragraph) notFound();

  const { data: existing } = await supabase
    .from("te_gist_notes")
    .select(
      "main_idea_text, supporting_text, structure_notes, structure_done_at",
    )
    .eq("user_id", userId)
    .eq("paragraph_id", paragraph.id)
    .maybeSingle();

  // 1회독 (Gist) 안 되어 있으면 먼저 1회독부터
  if (!existing?.main_idea_text || !existing?.supporting_text) {
    redirect(`/learn/paragraphs/${paragraph.id}/gist`);
  }

  const passage = Array.isArray(paragraph.te_passages)
    ? paragraph.te_passages[0]
    : paragraph.te_passages;

  return (
    <div className="space-y-6">
      <div>
        <Link
          href={`/learn/passages/${passage?.id}`}
          className="text-sm text-gray-500 hover:text-gray-900"
        >
          ← {passage?.title}
        </Link>
        <h1 className="text-2xl font-bold mt-2">
          단락 {paragraph.ord + 1} — 2회독 Structure
        </h1>
        <p className="text-gray-600 mt-2 text-sm">
          1회독에서 잡은 메인 아이디어를 바탕으로, 이 단락의{" "}
          <b>핵심 영어 구조·어법 포인트</b>를 자기 말로 메모하세요.
        </p>
      </div>

      <StructureWorkspace
        paragraphId={paragraph.id}
        paragraphBody={paragraph.body}
        passageId={passage?.id ?? ""}
        gist={{
          mainIdea: existing.main_idea_text!,
          supporting: existing.supporting_text!,
        }}
        initial={{
          structureNotes: existing.structure_notes ?? "",
          structureDoneAt: existing.structure_done_at ?? null,
        }}
      />
    </div>
  );
}
