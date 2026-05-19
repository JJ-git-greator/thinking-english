import Link from "next/link";
import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import GistWorkspace from "./GistWorkspace";

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
    .select("main_idea_text, supporting_text, main_idea_offset, supporting_offset")
    .eq("user_id", userId)
    .eq("paragraph_id", paragraph.id)
    .maybeSingle();

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
          단락 {paragraph.ord + 1} — Gist 노트테이킹
        </h1>
        <p className="text-gray-600 mt-2">
          이 단락의 <b>메인 아이디어</b>가 되는 문장 하나와, 그것을 받쳐주는{" "}
          <b>서포팅 센텐스</b> 하나를 골라보세요. 문장을 클릭해서 표시하면 됩니다.
        </p>
      </div>

      <GistWorkspace paragraphId={paragraph.id} body={paragraph.body} initial={existing ?? null} />
    </div>
  );
}
