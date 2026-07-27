import { createClient } from "@/lib/supabase/server";

/**
 * 한 단락을 학습하는 고정 순서(스텝 러너).
 *
 * 학생이 "다음에 뭘 해야 하지?"를 고민하지 않도록, 단락 하나에 대해
 * 항상 같은 순서로 진행하고 모든 화면 아래에 [이전 / 다음] 버튼을 붙인다.
 *
 *   1 핵심 문장 찾기(Gist) → 2 주어·동사 → 3 직독직해 → 4 문장 구조
 *   → 5 한국어 재구성 → 6 이 지문 문제 풀기 → (다음 단락 1단계)
 *
 * 콘텐츠가 없는 단계(예: 이 지문에 주어·동사 문장이 없음)는 목록에서 빠진다.
 */

export type StepKey = "gist" | "sv" | "chunks" | "structure" | "reconstruct" | "quiz";

export interface FlowStep {
  key: StepKey;
  n: number;
  title: string;
  short: string;
  emoji: string;
  href: string;
  done: boolean;
}

export interface ParagraphFlow {
  passage: { id: string; title: string };
  paragraph: { id: string; ord: number; index: number; total: number };
  steps: FlowStep[];
  nextParagraph: { id: string; index: number } | null;
  prevParagraph: { id: string; index: number } | null;
  questionCount: number;
}

const STEP_META: Record<StepKey, { title: string; short: string; emoji: string }> = {
  gist: { title: "핵심 문장 찾기", short: "핵심 문장", emoji: "🔦" },
  sv: { title: "주어·동사 찾기", short: "주어·동사", emoji: "🔎" },
  chunks: { title: "직독직해", short: "직독직해", emoji: "📝" },
  structure: { title: "문장 구조 점검", short: "문장 구조", emoji: "🧱" },
  reconstruct: { title: "한국어로 재구성", short: "재구성", emoji: "🧠" },
  quiz: { title: "이 지문 문제 풀기", short: "문제 풀기", emoji: "🎯" },
};

export async function getParagraphFlow(
  supabase: ReturnType<typeof createClient>,
  paragraphId: string,
  userId: string,
): Promise<ParagraphFlow | null> {
  const { data: paragraph } = await supabase
    .from("te_paragraphs")
    .select("id, ord, passage_id, te_passages(id, title)")
    .eq("id", paragraphId)
    .maybeSingle();

  if (!paragraph) return null;

  const passageRel = Array.isArray(paragraph.te_passages)
    ? paragraph.te_passages[0]
    : (paragraph.te_passages as any);
  const passageId: string = paragraph.passage_id;
  const passage = {
    id: passageRel?.id ?? passageId,
    title: passageRel?.title ?? "지문",
  };

  const [
    siblingsRes,
    gistRes,
    chunkRes,
    svRes,
    structRes,
    reconRes,
    questionRes,
  ] = await Promise.all([
    supabase
      .from("te_paragraphs")
      .select("id, ord")
      .eq("passage_id", passageId)
      .order("ord", { ascending: true }),
    supabase
      .from("te_gist_notes")
      .select("main_idea_text, supporting_text, structure_done_at")
      .eq("user_id", userId)
      .eq("paragraph_id", paragraphId)
      .maybeSingle(),
    supabase.from("te_chunk_sentences").select("id").eq("paragraph_id", paragraphId),
    supabase.from("te_sv_drill_sentences").select("id").eq("passage_id", passageId),
    supabase.from("te_structure_questions").select("id").eq("paragraph_id", paragraphId),
    supabase
      .from("te_reconstruction_attempts")
      .select("id")
      .eq("user_id", userId)
      .eq("paragraph_id", paragraphId)
      .limit(1),
    supabase.from("te_questions").select("id").eq("passage_id", passageId),
  ]);

  const siblings = siblingsRes.data ?? [];
  const index = Math.max(
    0,
    siblings.findIndex((p) => p.id === paragraphId),
  );
  const nextSibling = siblings[index + 1] ?? null;
  const prevSibling = index > 0 ? siblings[index - 1] : null;

  const chunkIds = (chunkRes.data ?? []).map((c) => c.id);
  const svIds = (svRes.data ?? []).map((s) => s.id);
  const questionIds = (questionRes.data ?? []).map((q) => q.id);

  // 완료 여부 — 시도 기록이 있으면 done
  const [chunkAttemptRes, svAttemptRes, quizAttemptRes] = await Promise.all([
    chunkIds.length
      ? supabase
          .from("te_chunk_attempts")
          .select("id")
          .eq("user_id", userId)
          .eq("paragraph_id", paragraphId)
          .limit(1)
      : Promise.resolve({ data: [] as { id: string }[] }),
    svIds.length
      ? supabase
          .from("te_sv_drill_attempts")
          .select("id")
          .eq("user_id", userId)
          .in("sentence_id", svIds)
          .limit(1)
      : Promise.resolve({ data: [] as { id: string }[] }),
    questionIds.length
      ? supabase
          .from("te_question_attempts")
          .select("id")
          .eq("user_id", userId)
          .in("question_id", questionIds)
          .not("answered_at", "is", null)
          .limit(1)
      : Promise.resolve({ data: [] as { id: string }[] }),
  ]);

  const gist = gistRes.data;
  const gistDone = !!gist?.main_idea_text && !!gist?.supporting_text;

  const steps: FlowStep[] = [];
  const push = (key: StepKey, href: string, done: boolean) => {
    steps.push({ key, n: steps.length + 1, ...STEP_META[key], href, done });
  };

  push("gist", `/learn/paragraphs/${paragraphId}/gist`, gistDone);
  if (svIds.length > 0) {
    push(
      "sv",
      `/learn/sv/play?passage=${passageId}&from=${paragraphId}`,
      (svAttemptRes.data ?? []).length > 0,
    );
  }
  if (chunkIds.length > 0) {
    push("chunks", `/learn/chunks/${paragraphId}`, (chunkAttemptRes.data ?? []).length > 0);
  }
  if (structRes.data && structRes.data.length > 0) {
    push("structure", `/learn/paragraphs/${paragraphId}/structure`, !!gist?.structure_done_at);
  }
  push("reconstruct", `/learn/paragraphs/${paragraphId}/reconstruct`, (reconRes.data ?? []).length > 0);
  if (questionIds.length > 0) {
    push("quiz", `/learn/passages/${passageId}/quiz`, (quizAttemptRes.data ?? []).length > 0);
  }

  return {
    passage,
    paragraph: {
      id: paragraphId,
      ord: paragraph.ord,
      index,
      total: siblings.length,
    },
    steps,
    nextParagraph: nextSibling ? { id: nextSibling.id, index: index + 1 } : null,
    prevParagraph: prevSibling ? { id: prevSibling.id, index: index - 1 } : null,
    questionCount: questionIds.length,
  };
}

/** 현재 단계 기준 이전/다음 목적지 (단락 경계를 넘어감) */
export function resolveNeighbors(flow: ParagraphFlow, current: StepKey) {
  const i = flow.steps.findIndex((s) => s.key === current);
  const prevStep = i > 0 ? flow.steps[i - 1] : null;
  const nextStep = i >= 0 && i < flow.steps.length - 1 ? flow.steps[i + 1] : null;

  const prev = prevStep
    ? { href: prevStep.href, label: `${prevStep.n}. ${prevStep.title}` }
    : flow.prevParagraph
      ? {
          href: `/learn/paragraphs/${flow.prevParagraph.id}/gist`,
          label: `단락 ${flow.prevParagraph.index + 1}`,
        }
      : { href: `/learn/passages/${flow.passage.id}`, label: "지문 화면" };

  const next = nextStep
    ? { href: nextStep.href, label: `${nextStep.n}. ${nextStep.title}` }
    : flow.nextParagraph
      ? {
          href: `/learn/paragraphs/${flow.nextParagraph.id}/gist`,
          label: `단락 ${flow.nextParagraph.index + 1} 시작`,
        }
      : { href: `/learn/passages/${flow.passage.id}`, label: "지문 화면으로" };

  return { prev, next, isLastStep: !nextStep };
}
