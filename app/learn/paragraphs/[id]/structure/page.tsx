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

  // 1회독 (Gist) 안 되어 있으면 먼저 1회독부터
  const { data: gist } = await supabase
    .from("te_gist_notes")
    .select("main_idea_text, supporting_text, structure_done_at")
    .eq("user_id", userId)
    .eq("paragraph_id", paragraph.id)
    .maybeSingle();

  if (!gist?.main_idea_text || !gist?.supporting_text) {
    redirect(`/learn/paragraphs/${paragraph.id}/gist`);
  }

  // 단락에 묶인 Structure 객관식 가져오기
  const { data: questions } = await supabase
    .from("te_structure_questions")
    .select("id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation")
    .eq("paragraph_id", paragraph.id)
    .order("ord", { ascending: true });

  // 학생의 답안 기록 (이 단락의 문제별로 마지막 시도)
  const questionIds = (questions ?? []).map((q) => q.id);
  const { data: attempts } = questionIds.length
    ? await supabase
        .from("te_structure_attempts")
        .select("question_id, chosen_answer, is_correct, answered_at")
        .eq("user_id", userId)
        .in("question_id", questionIds)
        .order("answered_at", { ascending: false })
    : { data: [] };

  // 각 question에 대해 가장 최근 시도만 매칭
  const lastByQ = new Map<string, { chosen_answer: string; is_correct: boolean }>();
  for (const a of attempts ?? []) {
    if (!lastByQ.has(a.question_id)) {
      lastByQ.set(a.question_id, {
        chosen_answer: a.chosen_answer,
        is_correct: a.is_correct,
      });
    }
  }

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

      <div className="bg-gradient-to-r from-sky-500 to-blue-500 text-white rounded-2xl p-6 sm:p-7 shadow-md">
        <div className="flex items-center justify-between mb-1 gap-3 flex-wrap">
          <div className="text-xs font-semibold text-sky-50">📖 단락 깊이 읽기 · 2/3단계 (Structure)</div>
          <div className="hidden sm:flex items-center gap-1 text-xs text-white/80">
            <span className="px-2 py-0.5 rounded-full bg-white/10">1회독 ✓</span>
            <span>→</span>
            <span className="px-2 py-0.5 rounded-full bg-white/20 font-bold">2회독</span>
            <span>→</span>
            <span className="px-2 py-0.5 rounded-full bg-white/10">3회독</span>
          </div>
        </div>
        <h1 className="text-2xl sm:text-3xl font-bold leading-tight">
          단락 {paragraph.ord + 1} — 구조와 어법 점검
        </h1>
        <p className="text-sky-50 mt-2 text-sm sm:text-base">
          이 단락의 <b className="text-white">주어 · 동사 일치 · 구조</b>를 3문제로 점검합니다.
          답을 고르면 즉시 해설이 나와요.
        </p>
      </div>

      <StructureWorkspace
        paragraphId={paragraph.id}
        paragraphBody={paragraph.body}
        passageId={passage?.id ?? ""}
        questions={(questions ?? []).map((q) => ({
          id: q.id,
          ord: q.ord,
          kind: q.kind,
          prompt: q.prompt,
          target_sentence: q.target_sentence,
          choices: q.choices,
          correct_answer: q.correct_answer,
          explanation: q.explanation,
          last: lastByQ.get(q.id) ?? null,
        }))}
      />
    </div>
  );
}
