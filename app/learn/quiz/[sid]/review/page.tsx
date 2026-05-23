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

  // 1) 시도 (단순)
  const { data: attempts } = await supabase
    .from("te_question_attempts")
    .select(
      "id, ord, question_id, chosen_answer, reason_text, is_correct, remediation_text",
    )
    .eq("session_id", session.id)
    .order("ord", { ascending: true });

  if (!attempts || attempts.length === 0) {
    // 진단 가능한 에러 UI (404 대신)
    return (
      <div className="space-y-4">
        <Link
          href="/learn/quiz"
          className="text-sm text-gray-500 hover:text-gray-900"
        >
          ← 카테고리
        </Link>
        <div className="bg-amber-50 border border-amber-200 rounded-xl p-6 text-center space-y-2">
          <div className="text-4xl">⚠️</div>
          <p className="text-gray-800 font-semibold">이 세션의 답안을 불러오지 못했어요</p>
          <p className="text-sm text-gray-600">
            잠시 후 다시 시도해 주세요. 문제가 반복되면 새 세션을 시작해 보세요.
          </p>
          <Link
            href="/learn/quiz"
            className="inline-block mt-2 px-4 py-2 rounded-md bg-brand-600 text-white text-sm font-semibold hover:bg-brand-700"
          >
            카테고리로 돌아가기
          </Link>
        </div>
      </div>
    );
  }

  // 2) 문제 (질문 id로 일괄)
  const questionIds = Array.from(new Set(attempts.map((a) => a.question_id)));
  const { data: questions } = await supabase
    .from("te_questions")
    .select("id, prompt, choices, correct_answer, explanation, passage_id")
    .in("id", questionIds);
  const qMap = new Map<string, any>();
  for (const q of questions ?? []) qMap.set(q.id, q);

  // 3) 지문 (질문에서 모은 passage_id로 일괄)
  const passageIds = Array.from(
    new Set((questions ?? []).map((q: any) => q.passage_id).filter(Boolean)),
  );
  const { data: passages } = passageIds.length
    ? await supabase
        .from("te_passages")
        .select("id, title, body")
        .in("id", passageIds)
    : { data: [] };
  const pMap = new Map<string, any>();
  for (const p of passages ?? []) pMap.set(p.id, p);

  // 4) 단락 (지문 id로 일괄, 결합용)
  const { data: paragraphs } = passageIds.length
    ? await supabase
        .from("te_paragraphs")
        .select("passage_id, ord, body")
        .in("passage_id", passageIds)
        .order("ord", { ascending: true })
    : { data: [] };
  const paragraphsByPassage = new Map<string, { ord: number; body: string }[]>();
  for (const para of paragraphs ?? []) {
    const arr = paragraphsByPassage.get(para.passage_id) ?? [];
    arr.push({ ord: para.ord, body: para.body });
    paragraphsByPassage.set(para.passage_id, arr);
  }

  const totalCorrect = session.total_correct ?? 0;
  const total = session.batch_size ?? attempts.length;

  const mapped = attempts.map((a) => {
    const q = qMap.get(a.question_id);
    const passage = q?.passage_id ? pMap.get(q.passage_id) : null;
    const paras = passage ? paragraphsByPassage.get(passage.id) ?? [] : [];
    const fullText = [passage?.body ?? "", ...paras.map((p) => p.body)]
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
      passage: passage ? { title: passage.title, body: fullText } : null,
    };
  });

  return (
    <div className="space-y-6">
      <div>
        <Link
          href="/learn/quiz"
          className="text-sm text-gray-500 hover:text-gray-900"
        >
          ← 카테고리
        </Link>
        <h1 className="text-2xl font-bold mt-2">채점 결과 + 오답 정리</h1>
        <p className="text-gray-600 mt-1 text-sm">
          오답을 그냥 넘기지 마세요. <b>왜 틀렸는지 한 줄 적어야</b> 다음 묶음으로
          넘어갑니다. 이 정리가 곧 다음 풀이의 정답률을 만듭니다.
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
        attempts={mapped}
      />
    </div>
  );
}
