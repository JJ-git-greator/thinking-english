import Link from "next/link";
import { notFound, redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import ChunkWorkspace from "./ChunkWorkspace";

export default async function ChunkParagraphPage({
  params,
}: {
  params: { id: string };
}) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) redirect("/login");

  const { data: paragraph } = await supabase
    .from("te_paragraphs")
    .select("id, ord, body, passage_id, te_passages(id, title, difficulty)")
    .eq("id", params.id)
    .maybeSingle();

  if (!paragraph) notFound();

  const { data: sentences } = await supabase
    .from("te_chunk_sentences")
    .select("id, ord, full_sentence, chunks, note")
    .eq("paragraph_id", paragraph.id)
    .order("ord", { ascending: true });

  const passage = Array.isArray(paragraph.te_passages)
    ? paragraph.te_passages[0]
    : paragraph.te_passages;

  return (
    <div className="space-y-6">
      <Link
        href="/learn/chunks"
        className="inline-flex items-center text-sm text-gray-500 hover:text-gray-900"
      >
        ← 직독직해 훈련
      </Link>

      <div className="bg-gradient-to-r from-purple-500 to-fuchsia-500 text-white rounded-2xl p-6 sm:p-7 shadow-md">
        <div className="text-xs font-semibold text-purple-50 mb-1">
          📝 직독직해 — 끊어 읽고 즉시 해석
        </div>
        <h1 className="text-2xl sm:text-3xl font-bold leading-tight">
          {passage?.title} · 단락 {paragraph.ord + 1}
        </h1>
        <p className="text-purple-50 mt-2 text-sm sm:text-base">
          영어 어순 그대로 왼쪽부터 청크 단위로 읽으세요. 청크마다 한국어 의미를 떠올린 후
          버튼을 눌러 확인합니다. 절대 되돌아가지 않는 게 핵심입니다.
        </p>
      </div>

      <ChunkWorkspace
        paragraphId={paragraph.id}
        paragraphBody={paragraph.body}
        passageId={passage?.id ?? ""}
        passageTitle={passage?.title ?? ""}
        sentences={(sentences ?? []).map((s) => ({
          id: s.id,
          ord: s.ord,
          full_sentence: s.full_sentence,
          chunks: s.chunks as { en: string; ko: string }[],
          note: s.note,
        }))}
      />
    </div>
  );
}
