import Link from "next/link";
import { notFound, redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import ReviewWorkspace from "./ReviewWorkspace";

export default async function ReviewPage({ params }: { params: { sid: string } }) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) redirect("/login");

  const { data: session } = await supabase
    .from("te_quiz_sessions")
    .select("id, topic, batch_size, completed_at, total_correct, remediation_done")
    .eq("id", params.sid)
    .maybeSingle();

  if (!session) notFound();
  if (!session.completed_at) {
    redirect(`/learn/quiz/${session.id}/play`);
  }

  const { data: attempts } = await supabase
    .from("te_question_attempts")
    .select(
      "id, ord, chosen_answer, reason_text, is_correct, remediation_text, te_questions(prompt, choices, correct_answer, explanation, te_passages(title, body, te_paragraphs(ord, body)))",
    )
    .eq("session_id", session.id)
    .order("ord", { ascending: true });

  if (!attempts || attempts.length === 0) notFound();

  const totalCorrect = session.total_correct ?? 0;
  const total = session.batch_size ?? attempts.length;

  return (
    <div className="space-y-6">
      <div>
        <Link
          href="/learn/quiz"
          className="text-sm text-gray-500 hover:text-gray-900"
        >
          ← 카테고리
        </Link>
        <h1 className="text-2xl font-bold mt-2">채점 결과 + 오답 교정</h1>
        <p className="text-gray-600 mt-1 text-sm">
          오답은 그냥 넘기지 마세요. <b>왜 틀렸는지 한 줄 적어야</b> 다음 묶음으로
          넘어갈 수 있습니다. 사고력 훈련의 핵심이에요.
        </p>
      </div>

      <div className="bg-white border rounded-lg p-5">
        <div className="flex items-baseline gap-3">
          <span className="text-5xl font-bold text-brand-600">{totalCorrect}</span>
          <span className="text-gray-500">/ {total} 정답</span>
        </div>
      </div>

      <ReviewWorkspace
        sessionId={session.id}
        sessionTopic={session.topic}
        initialRemediationDone={session.remediation_done ?? false}
        attempts={(attempts ?? []).map((a) => {
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
            is_correct: a.is_correct,
            remediation_text: a.remediation_text,
            prompt: q?.prompt ?? "",
            choices: q?.choices ?? [],
            correct_answer: q?.correct_answer ?? "",
            explanation: q?.explanation ?? "",
            passage: passage
              ? { title: passage.title, body: fullText }
              : null,
          };
        })}
      />
    </div>
  );
}
