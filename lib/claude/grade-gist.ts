import { claude, MODELS } from "./client";

export interface GistGradePayload {
  paragraphBody: string;
  studentMainText: string;
  studentSupportingText: string;
  mainReasoning?: string;        // 학생이 입력한 근거 (옵션)
  supportingReasoning?: string;
  preferSmart?: boolean;
}

export interface GistGradeResult {
  overall: number;                // 0~100
  main_accuracy: number;          // 0~100, 메인 선택 적합도
  supporting_accuracy: number;    // 0~100, 서포팅 선택 적합도
  reasoning_quality: number;      // 0~100, 학생이 적은 근거의 합리성 (근거 없으면 0)
  feedback: {
    main: string;                 // 메인 선택에 대한 코칭 한 줄
    supporting: string;           // 서포팅 선택에 대한 코칭 한 줄
    reasoning?: string;           // 근거 입력이 있었으면 그에 대한 한 줄
    better_main?: string;         // 더 적절한 메인 후보가 있다면 인용
    better_supporting?: string;
  };
  next_step: string;              // 다음 단계에 학생이 더 잘 할 수 있는 한 줄 코칭
  model: string;
}

const SYSTEM_PROMPT = `역할: 한국 중·고등학생 영어 지문 이해 학습 채점관.

훈련 방식: 학생은 영어 단락을 읽고, 그 안에서 핵심 문장(메인 아이디어)과 그것을 뒷받침하는 보조 문장(서포팅 센텐스)을 골랐다.
선택 근거를 함께 적었을 수 있다. 너의 임무는 학생의 선택과 근거를 평가하는 것이다.

평가 기준
1. **main_accuracy (0~100)**: 학생이 고른 메인 문장이 단락의 진짜 핵심 메시지인가?
   - 정확한 핵심 문장이면 85+
   - 핵심에 가깝지만 약간 더 적절한 문장이 있으면 65~84
   - 서포팅으로 더 어울리는 문장을 메인으로 잡았다면 40~64
   - 단락 주제와 거리가 멀다면 39 이하

2. **supporting_accuracy (0~100)**: 학생이 고른 서포팅 문장이 메인을 잘 받쳐주는가?
   - 메인을 직접 예시·근거로 뒷받침하면 85+
   - 단락 흐름의 일부지만 메인 직결성이 약하면 60~84
   - 메인과 무관하거나 두 번째 주제를 다루면 60 이하

3. **reasoning_quality (0~100)**: 학생이 적은 선택 근거가 합리적인가?
   - 근거 미입력이면 0
   - "마지막 문장이 결론이라서" 같은 텍스트 근거를 짚었으면 70+
   - 단순히 "이게 메인일 것 같아서" 같은 막연한 근거면 40~60

4. **overall**: 위 셋의 가중 평균 (main 40%, supporting 30%, reasoning 30%). 근거 미입력 시 main 60%, supporting 40%.

피드백 작성 원칙
- 한국어로 중·고등학생 톤
- 잘했으면 칭찬, 더 좋은 후보가 있으면 그 문장을 짧게 인용해서 보여줌
- "이게 틀렸어요"가 아니라 "이 문장도 좋지만, ~ 문장이 더 핵심에 가까워요" 톤
- next_step: 다음 단락에서 학생이 더 잘 할 수 있는 사고 방향 한 줄

출력 형식: 오직 JSON 한 덩어리. 다른 텍스트 없이.
{
  "overall": 0-100 정수,
  "main_accuracy": 0-100 정수,
  "supporting_accuracy": 0-100 정수,
  "reasoning_quality": 0-100 정수,
  "feedback": {
    "main": "...",
    "supporting": "...",
    "reasoning": "..." (근거 입력 있을 때만),
    "better_main": "..." (더 좋은 메인 후보 있을 때만, 영어 문장 그대로),
    "better_supporting": "..." (더 좋은 서포팅 후보 있을 때만, 영어 문장 그대로)
  },
  "next_step": "..."
}`;

export async function gradeGist(p: GistGradePayload): Promise<GistGradeResult> {
  const modelId = p.preferSmart ? MODELS.smart : MODELS.cheap;
  const client = claude();

  const userText = [
    "원문 단락 (영어):",
    '"""',
    p.paragraphBody,
    '"""',
    "",
    `학생이 고른 메인 아이디어: "${p.studentMainText}"`,
    p.mainReasoning ? `학생의 메인 선택 근거: ${p.mainReasoning}` : "(메인 근거 입력 없음)",
    "",
    `학생이 고른 서포팅 센텐스: "${p.studentSupportingText}"`,
    p.supportingReasoning ? `학생의 서포팅 선택 근거: ${p.supportingReasoning}` : "(서포팅 근거 입력 없음)",
    "",
    "위 학생의 선택과 근거를 평가해 주세요. 출력은 JSON만.",
  ].join("\n");

  const resp = await client.messages.create({
    model: modelId,
    max_tokens: 1000,
    system: [
      {
        type: "text",
        text: SYSTEM_PROMPT,
        cache_control: { type: "ephemeral" },
      },
    ],
    messages: [{ role: "user", content: userText }],
  });

  const raw = resp.content
    .map((b) => (b.type === "text" ? b.text : ""))
    .join("")
    .trim();

  return { ...extractJson(raw), model: modelId };
}

function extractJson(s: string): Omit<GistGradeResult, "model"> {
  const start = s.indexOf("{");
  const end = s.lastIndexOf("}");
  if (start === -1 || end === -1) throw new Error("Claude 응답에서 JSON을 찾지 못했습니다.");
  const obj = JSON.parse(s.slice(start, end + 1));
  return {
    overall: clamp(Number(obj.overall), 0, 100),
    main_accuracy: clamp(Number(obj.main_accuracy), 0, 100),
    supporting_accuracy: clamp(Number(obj.supporting_accuracy), 0, 100),
    reasoning_quality: clamp(Number(obj.reasoning_quality), 0, 100),
    feedback: {
      main: String(obj.feedback?.main ?? ""),
      supporting: String(obj.feedback?.supporting ?? ""),
      reasoning: obj.feedback?.reasoning ? String(obj.feedback.reasoning) : undefined,
      better_main: obj.feedback?.better_main ? String(obj.feedback.better_main) : undefined,
      better_supporting: obj.feedback?.better_supporting ? String(obj.feedback.better_supporting) : undefined,
    },
    next_step: String(obj.next_step ?? ""),
  };
}

function clamp(n: number, lo: number, hi: number) {
  if (!Number.isFinite(n)) return 0;
  return Math.max(lo, Math.min(hi, Math.round(n)));
}
