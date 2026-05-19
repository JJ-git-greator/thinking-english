import Link from "next/link";
import { notFound, redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import PlayWorkspace from "./PlayWorkspace";

export default async function PlayPage({ params }: { params: { sid: string } }) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) redirect("/login");

  const { data: session } = await supabase
    .from("te_quiz_sessions")
    .select("id, topic, batch_size, completed_at, total_correct, remediation_done")
    .eq("id", params.sid)
    .maybeSingle();

  if (!session) notFound();
  if (session.completed_at) {
    redirect(`/learn/quiz/${session.id}/review`);
  }

  const { data: attempts } = await supabase
    .from("te_question_attempts")
    .select(
      "id, ord, chosen_answer, reason_text, question_id, te_questions(prompt, choices, passage_id, te_passages(title, body, te_paragraphs(ord, body)))",
    )
    .eq("session_id", session.id)
    .order("ord", { ascending: true });

  if (!attempts || attempts.length === 0) notFound();

  // Find first unanswered attempt
  const firstUnanswered =
    attempts.findIndex((a) => !a.chosen_answer) === -1
      ? attempts.length - 1
      : attempts.findIndex((a) => !a.chosen_answer);

  const total = attempts.length;
  const answered = attempts.filter((a) => !!a.chosen_answer).length;

  return (
    <div className="space-y-6">
      <div>
        <Link
          href="/learn/quiz"
          className="text-sm text-gray-500 hover:text-gray-900"
        >
          ← 카테고리
        </Link>
        <h1 className="text-2xl font-bold mt-2">10문제 컷팅 학습</h1>
        <p className="text-gray-600 mt-1 text-sm">
          답을 고르고 <b>왜 그 답을 골랐는지 근거를 한 줄</b>로 적어주세요. 10문제
          다 풀면 즉시 채점 + 오답 교정으로 넘어갑니다.
        </p>
        <div className="text-sm text-gray-500 mt-2">
          진행: {answered} / {total}
        </div>
      </div>

      <PlayWorkspace
        sessionId={session.id}
        initialIndex={firstUnanswered}
        attempts={attempts.map((a) => {
          const q = Array.isArray(a.te_questions) ? a.te_questions[0] : (a.te_questions as any);
          const passage = q && (Array.isArray(q.te_passages) ? q.te_passages[0] : q.te_passages);
          const paragraphs = passage?.te_paragraphs
            ? (Array.isArray(passage.te_paragraphs)
                ? passage.te_paragraphs
                : [passage.te_paragraphs])
            : [];
          const fullText = [
            passage?.body ?? "",
            ...paragraphs
              .slice()
              .sort((x: any, y: any) => x.ord - y.ord)
              .map((p: any) => p.body),
          ]
            .filter(Boolean)
            .join("\n\n");
          return {
            id: a.id,
            ord: a.ord,
            chosen_answer: a.chosen_answer,
            reason_text: a.reason_text,
            question: {
              prompt: q?.prompt ?? "",
              choices: q?.choices ?? [],
              passage: passage
                ? { title: passage.title, body: fullText }
                : null,
            },
          };
        })}
      />
    </div>
  );
}
