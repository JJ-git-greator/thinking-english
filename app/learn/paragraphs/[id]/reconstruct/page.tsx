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
      <div>
        <Link
          href={`/learn/passages/${passage?.id}`}
          className="text-sm text-gray-500 hover:text-gray-900"
        >
          ← {passage?.title}
        </Link>
        <h1 className="text-2xl font-bold mt-2">
          단락 {paragraph.ord + 1} — 역방향 재구성
        </h1>
        <p className="text-gray-600 mt-2">
          본문은 가려집니다. 아래 두 문장만 보고, 단락 전체 내용이 어떻게
          이어지는지 <b>한국어로 자기 말로 풀어써 보세요</b>. 영어 작문이 아니라
          <b> 사고력 훈련</b>이에요. AI가 채점하고 코칭을 남깁니다.
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
