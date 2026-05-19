import { claude, MODELS } from "./client";

export interface GradePayload {
  paragraphBody: string;       // 원문 (영어)
  mainIdea: string;            // 학생이 찾은 메인 아이디어 (영어 문장)
  supporting: string;          // 학생이 찾은 서포팅 센텐스 (영어 문장)
  studentText: string;         // 학생이 한국어로 재구성한 글
  preferSmart?: boolean;
}

export interface GradeResult {
  score: number;
  subscores: {
    main: number;       // 핵심 메시지 일치도
    support: number;    // 디테일 반영
    flow: number;       // 논리 흐름
    expression: number; // 표현 적절성 (한국어)
  };
  strengths: string[];
  weaknesses: string[];
  suggestions: string[];
  rewritten_example: string;   // 한국어 모범 예시
  model: string;
}

const SYSTEM_PROMPT = `역할: 한국 중·고등학생 사고력 영어 학습 채점관.

훈련 방식: 학생은 영어 단락을 읽고 그 안에서 메인 아이디어 한 문장 + 서포팅 센텐스 한 문장을 골랐다.
지금 학생은 두 문장만 보고, 원문은 가린 상태에서, 단락 전체 내용을 **자기 말의 한국어로** 재구성해 적었다.

이 훈련은 영어 작문 능력 시험이 아니다. **단락을 진짜로 이해했는지, 두 핵심 문장으로부터 전체 내용을 머릿속에 재구성할 수 있는지**를 본다.

평가 기준 (각 0~25점, 합계 0~100점)

**점수 보정 원칙 (매우 중요)**
이 훈련의 정신은 "메인 두 문장으로 단락 전체를 자기 말로 이야기해보기"다. 시험이 아니라 사고력 자극이다. 따라서 **각 축은 최소 18점부터 시작한다고 가정하고, 명확한 결함이 있을 때만 깎는다.** 학생이 단락의 핵심을 잡았으면 80점 이상 나와야 정상이다. 60점대는 핵심을 거의 못 잡았을 때만 준다.

1. **핵심 메시지 일치도 (main)**: 단락의 중심 주장을 잡았는가
   - 핵심을 잡았으면 22~25
   - 살짝 빗나갔으면 17~21
   - 완전히 못 잡았을 때만 16 이하

2. **서포팅 디테일 반영 (support)**: 단락의 구체 예시·근거를 얼마나 짚어냈는가
   - 디테일 1~2개 포함하면 22+
   - 일부 누락도 18+
   - 단락의 절반 이상을 놓쳤을 때만 17 이하

3. **논리 흐름 (flow)**: 내용 순서·인과가 자연스러운가
   - 흐름이 이어지면 20+
   - 짧고 단편적이어도 의미 연결만 되면 18+
   - 명백히 모순되거나 뒤죽박죽일 때만 17 이하

4. **한국어 표현 적절성 (expression)**: 학년 수준에서 자연스럽게 썼는가
   - **맞춤법·띄어쓰기·문법 오류는 절대 깎지 마라**. 사고력 훈련이지 국어 시험이 아니다
   - 학생 수준에서 의미 전달이 되면 22+
   - "쓸모없다 vs 약하다" 같은 표현 강도 차이도 깎지 마라 — 자기 말로 푼 것이므로 OK
   - 의미가 완전히 안 통할 정도로 어색할 때만 17 이하

**개선점·다음 시도 작성 원칙**
- 맞춤법·띄어쓰기 지적 **절대 금지**
- 표현 강도 차이로 "극단적이다" 같은 지적 금지
- 오직 **이해·재구성 사고 측면**에서만 코칭한다
- 학생이 더 잘 했으면 좋겠는 **사고 방향**을 제시한다 (예: "단락의 두 번째 흐름까지 포함하면 더 완전해진다")

피드백은 한국어로, 중·고등학생 동기부여에 적합하게. 모범 예시도 한국어, 학생 수준에서 따라할 만하게.

출력 형식: 오직 JSON 한 덩어리. 다른 텍스트 없이.
{
  "score": 0-100 정수,
  "subscores": { "main": 0-25, "support": 0-25, "flow": 0-25, "expression": 0-25 },
  "strengths": ["...", "..."],
  "weaknesses": ["...", "..."],
  "suggestions": ["...", "..."],
  "rewritten_example": "한국어 모범 예시 한 단락"
}`;

export async function gradeReconstruction(p: GradePayload): Promise<GradeResult> {
  const modelId = p.preferSmart ? MODELS.smart : MODELS.cheap;
  const client = claude();

  const userText = [
    "원문 단락 (영어):",
    '"""',
    p.paragraphBody,
    '"""',
    "",
    "학생이 골라낸 두 문장:",
    `- 메인 아이디어: "${p.mainIdea}"`,
    `- 서포팅 센텐스: "${p.supporting}"`,
    "",
    "학생이 한국어로 재구성한 글:",
    '"""',
    p.studentText,
    '"""',
    "",
    "위 학생의 한국어 재구성을 평가해 주세요. 출력은 JSON만.",
  ].join("\n");

  const resp = await client.messages.create({
    model: modelId,
    max_tokens: 1200,
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

  const parsed = extractJson(raw);
  return { ...parsed, model: modelId };
}

function extractJson(s: string): Omit<GradeResult, "model"> {
  const start = s.indexOf("{");
  const end = s.lastIndexOf("}");
  if (start === -1 || end === -1) throw new Error("Claude 응답에서 JSON을 찾지 못했습니다.");
  const json = s.slice(start, end + 1);
  const obj = JSON.parse(json);
  return {
    score: clamp(Number(obj.score), 0, 100),
    subscores: {
      main: clamp(Number(obj.subscores?.main), 0, 25),
      support: clamp(Number(obj.subscores?.support), 0, 25),
      flow: clamp(Number(obj.subscores?.flow), 0, 25),
      expression: clamp(Number(obj.subscores?.expression ?? obj.subscores?.language), 0, 25),
    },
    strengths: arr(obj.strengths),
    weaknesses: arr(obj.weaknesses),
    suggestions: arr(obj.suggestions),
    rewritten_example: String(obj.rewritten_example ?? ""),
  };
}

function clamp(n: number, lo: number, hi: number) {
  if (!Number.isFinite(n)) return 0;
  return Math.max(lo, Math.min(hi, Math.round(n)));
}
function arr(v: unknown): string[] {
  if (!Array.isArray(v)) return [];
  return v.map((x) => String(x)).slice(0, 5);
}
