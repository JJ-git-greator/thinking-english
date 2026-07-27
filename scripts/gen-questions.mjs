/**
 * 지문 묶음 문제 증량 — 지문당 목표 8문제(주제 3 / 빈칸 3 / 어휘 2)가 되도록 부족분만 생성.
 *
 * 왜: 유형 훈련을 "방금 읽은 그 지문"으로 바꿨는데, 지문당 문제가 3개뿐이라 세트가 얇았다.
 *
 * 안전장치
 *  - 생성물은 전부 코드로 검증한다 (빈칸 문장은 원문에 실제로 있는지, 어휘는 본문에 나오는 단어인지,
 *    보기 4개·정답 키 유효·해설 한국어·중복 프롬프트 여부). 통과 못 하면 버리고 1회만 재시도.
 *  - 기존 문제는 절대 건드리지 않고 insert 만 한다.
 *  - 기본은 dry-run. --apply 를 줘야 DB 반영.
 *
 * 실행:
 *   node scripts/gen-questions.mjs --passage <id>        # 파일럿 (1지문, dry-run)
 *   node scripts/gen-questions.mjs --limit 3 --apply
 *   node scripts/gen-questions.mjs --apply               # 전체
 */
import Anthropic from "@anthropic-ai/sdk";
import { loadEnv, supa, isMojibake } from "./lib/seed-questions.mjs";

const args = process.argv.slice(2);
const APPLY = args.includes("--apply");
const LIMIT = num("--limit", Infinity);
const TARGET = num("--target", 8);
const ONLY = str("--passage", null);
const MODEL = "claude-sonnet-4-6";
const CONCURRENCY = 4;

function num(flag, dflt) {
  const i = args.indexOf(flag);
  return i === -1 ? dflt : Number(args[i + 1]);
}
function str(flag, dflt) {
  const i = args.indexOf(flag);
  return i === -1 ? dflt : args[i + 1];
}

const env = loadEnv(process.cwd());
const db = supa(env);
const claude = new Anthropic({ apiKey: env.ANTHROPIC_API_KEY });

const TOPIC_TARGET = { main_idea: 3, blank: 3, vocabulary: 2 };

const SYSTEM = `역할: 한국 중·고등학생용 영어 지문 문제 출제자.

주어진 영어 지문 하나만 보고 객관식 4지선다 문제를 만든다. 학생은 이 지문을 이미
깊이 읽었고(핵심 문장 찾기 → 직독직해 → 문장 구조 → 한국어 재구성), 마지막 확인 단계로 이 문제를 푼다.

유형
- main_idea : 지문의 주제/요지/제목/필자의 관점을 묻는다. 매번 같은 질문 문구를 쓰지 말고
              (What is the main idea? / Which title best fits? / What is the writer's main point?) 다양하게.
- blank     : 지문 안에 **실제로 있는 문장 하나를 글자 그대로 가져와** 핵심 단어·구 하나를 ____ 로 비운다.
              문장을 새로 쓰거나 고치면 안 된다. 원문 그대로여야 한다.
- vocabulary: 지문에 **실제로 나오는 단어**를 골라 문맥상 의미를 묻는다. 지문에 없는 단어 금지.

절대 규칙
1. 정답은 지문만 읽고 확실히 하나로 정해져야 한다. 배경지식이 필요하면 안 된다.
2. 오답 3개도 **그럴듯해야 한다.** 지문에 나온 단어·개념을 쓰되 논리를 살짝 비틀어 만든다.
   "a kind of weather" 같은 장난스러운 오답, 길이가 혼자 튀는 오답 금지.
3. 보기는 정확히 4개, key 는 "1","2","3","4". 정답 위치는 문제마다 섞는다.
4. explanation 은 **한국어 한두 문장**, 중학생이 아는 쉬운 말. 왜 그게 정답인지 + 지문 어디를 보면 되는지.
   문장은 **해요체로 끝낸다**("~예요", "~해요"). "~이다/~한다" 같은 문어체 금지.
   위치는 "두 번째 단락", "마지막 문장"처럼 가리킨다(짧은 표현 인용은 괜찮다).
5. 기존 문제와 겹치는 질문은 만들지 않는다.

출력 형식: 오직 JSON 배열 하나. 다른 텍스트 없이.
[
  {
    "topic": "main_idea" | "blank" | "vocabulary",
    "prompt": "영어 질문. blank 유형은 'Fill in the blank: <원문 문장에서 한 곳을 ____ 로>' 형식",
    "choices": [{"key":"1","text":"..."},{"key":"2","text":"..."},{"key":"3","text":"..."},{"key":"4","text":"..."}],
    "correct_answer": "1",
    "explanation": "한국어 한두 문장"
  }
]`;

// ── 검증 ────────────────────────────────────────────────────────────────────
const norm = (s) =>
  String(s ?? "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, " ")
    .trim();

function validate(q, ctx) {
  const errs = [];
  if (!["main_idea", "blank", "vocabulary"].includes(q.topic)) errs.push("topic 값이 잘못됨");
  if (typeof q.prompt !== "string" || q.prompt.trim().length < 10) errs.push("prompt 가 너무 짧음");

  const choices = Array.isArray(q.choices) ? q.choices : [];
  if (choices.length !== 4) errs.push("보기가 4개가 아님");
  const keys = choices.map((c) => String(c?.key));
  if (new Set(keys).size !== 4 || !keys.every((k) => ["1", "2", "3", "4"].includes(k)))
    errs.push('보기 key 는 "1"~"4" 각각 하나씩이어야 함');
  const texts = choices.map((c) => String(c?.text ?? "").trim());
  if (texts.some((t) => t.length === 0)) errs.push("빈 보기 있음");
  if (new Set(texts.map(norm)).size !== texts.length) errs.push("보기 내용이 서로 중복됨");
  if (texts.some((t) => t.length > 160)) errs.push("보기가 너무 김");
  if (!keys.includes(String(q.correct_answer))) errs.push("correct_answer 가 보기 key 에 없음");

  const expl = String(q.explanation ?? "");
  if (!/[가-힣]/.test(expl)) errs.push("explanation 이 한국어가 아님");
  if (isMojibake(expl)) errs.push("explanation 인코딩 깨짐");
  if (expl.length > 160) errs.push("explanation 이 너무 김(160자 초과)");

  const answerText = texts[keys.indexOf(String(q.correct_answer))] ?? "";

  if (q.topic === "blank") {
    if (!q.prompt.includes("____")) errs.push("blank 인데 ____ 가 없음");
    else {
      const stem = q.prompt.replace(/^[^:]*:\s*/, "");
      const filled = norm(stem.replace(/_{2,}/g, ` ${answerText} `));
      if (!ctx.normText.includes(filled)) errs.push("빈칸 문장이 원문에 그대로 있지 않음");
    }
  }

  if (q.topic === "vocabulary") {
    const quoted = q.prompt.match(/["“”']([A-Za-z][A-Za-z\- ]{1,30})["“”']/);
    const word = quoted?.[1];
    if (!word) errs.push("어휘 문제인데 대상 단어가 따옴표로 표시되지 않음");
    else {
      const stem = norm(word).replace(/(ing|ed|es|s)$/, "");
      if (!ctx.normText.includes(norm(word)) && !ctx.normText.includes(stem))
        errs.push(`"${word}" 가 지문에 없음`);
    }
  }

  if (ctx.seenPrompts.has(norm(q.prompt))) errs.push("이미 있는 문제와 질문이 겹침");

  return errs;
}

// ── 생성 ────────────────────────────────────────────────────────────────────
async function generateForPassage(p) {
  const need = { ...TOPIC_TARGET };
  for (const q of p.existing) if (need[q.topic] != null) need[q.topic] = Math.max(0, need[q.topic] - 1);
  const totalNeed = Math.min(
    Object.values(need).reduce((a, b) => a + b, 0),
    Math.max(0, TARGET - p.existing.length),
  );
  if (totalNeed <= 0) return { passage: p, created: [], skipped: true };

  const ctx = {
    normText: norm(p.fullText),
    seenPrompts: new Set(p.existing.map((q) => norm(q.prompt))),
  };

  const wanted = Object.entries(need)
    .filter(([, n]) => n > 0)
    .map(([t, n]) => `${t} ${n}개`)
    .join(", ");

  const baseUser = [
    `지문 제목: ${p.title}`,
    `난이도: ${p.difficulty ?? "mid"} · 학년: ${p.grade_level ?? "중3"}`,
    "",
    "지문 전문:",
    '"""',
    p.fullText,
    '"""',
    "",
    "이미 있는 문제(질문만, 겹치면 안 됨):",
    ...(p.existing.length ? p.existing.map((q) => `- [${q.topic}] ${q.prompt}`) : ["- (없음)"]),
    "",
    `만들 문제: 총 ${totalNeed}개 — ${wanted}. JSON 배열만 출력.`,
  ].join("\n");

  const accepted = [];
  let userText = baseUser;

  for (let round = 0; round < 2 && accepted.length < totalNeed; round++) {
    const resp = await claude.messages.create({
      model: MODEL,
      max_tokens: 3000,
      system: [{ type: "text", text: SYSTEM, cache_control: { type: "ephemeral" } }],
      messages: [{ role: "user", content: userText }],
    });
    const raw = resp.content.map((b) => (b.type === "text" ? b.text : "")).join("");
    let parsed;
    try {
      parsed = JSON.parse(raw.slice(raw.indexOf("["), raw.lastIndexOf("]") + 1));
    } catch {
      parsed = [];
    }

    const rejected = [];
    for (const q of parsed) {
      if (accepted.length >= totalNeed) break;
      const errs = validate(q, ctx);
      if (errs.length) {
        rejected.push({ q, errs });
        continue;
      }
      ctx.seenPrompts.add(norm(q.prompt));
      accepted.push(q);
    }

    if (accepted.length >= totalNeed) break;
    // 재시도 — 뭐가 왜 탈락했는지 알려주고 부족분만 다시
    const remain = totalNeed - accepted.length;
    userText = [
      baseUser,
      "",
      "이전 시도에서 탈락한 문제와 이유:",
      ...rejected.slice(0, 4).map((r) => `- ${String(r.q.prompt).slice(0, 70)} → ${r.errs.join("; ")}`),
      "",
      `이번엔 ${remain}개만, 위 이유를 피해서 다시 만들어라. 특히 blank 는 지문 문장을 글자 그대로 복사해서 한 곳만 ____ 로 바꿔라.`,
    ].join("\n");
  }

  const rows = accepted.map((q) => ({
    passage_id: p.id,
    topic: q.topic,
    prompt: q.prompt.trim(),
    choices: q.choices.map((c) => ({ key: String(c.key), text: String(c.text).trim() })),
    correct_answer: String(q.correct_answer),
    explanation: q.explanation.trim(),
    difficulty: p.difficulty,
    grade_level: p.grade_level,
    org_id: null,
  }));

  if (APPLY && rows.length) await db.insert("te_questions", rows);
  return { passage: p, created: rows, need: totalNeed };
}

// ── 실행 ────────────────────────────────────────────────────────────────────
const passages = await db.select(
  "te_passages?select=id,title,body,difficulty,grade_level&order=difficulty,title&limit=200",
);
const paragraphs = await db.select("te_paragraphs?select=passage_id,ord,body&order=ord&limit=2000");
const questions = await db.select("te_questions?select=id,passage_id,topic,prompt&limit=3000");

const paraBy = new Map();
for (const p of paragraphs) (paraBy.get(p.passage_id) ?? paraBy.set(p.passage_id, []).get(p.passage_id)).push(p);
const qBy = new Map();
for (const q of questions) (qBy.get(q.passage_id) ?? qBy.set(q.passage_id, []).get(q.passage_id)).push(q);

let targets = passages
  .filter((p) => !ONLY || p.id === ONLY)
  .map((p) => ({
    ...p,
    fullText: [p.body, ...(paraBy.get(p.id) ?? []).map((x) => x.body)].filter(Boolean).join("\n\n"),
    existing: qBy.get(p.id) ?? [],
  }))
  .filter((p) => p.existing.length < TARGET);

targets = targets.slice(0, LIMIT);
console.log(`대상 지문 ${targets.length}개 (목표 지문당 ${TARGET}문제) · ${APPLY ? "APPLY" : "DRY-RUN"}\n`);

let made = 0;
let short = 0;
for (let i = 0; i < targets.length; i += CONCURRENCY) {
  const batch = targets.slice(i, i + CONCURRENCY);
  const results = await Promise.all(
    batch.map((p) =>
      generateForPassage(p).catch((e) => ({ passage: p, created: [], error: String(e).slice(0, 120) })),
    ),
  );
  for (const r of results) {
    made += r.created.length;
    const flag = r.error ? `❌ ${r.error}` : r.created.length < (r.need ?? 0) ? `⚠️ ${r.created.length}/${r.need}` : `✓ +${r.created.length}`;
    if (r.created.length < (r.need ?? 0) || r.error) short++;
    console.log(`${flag}  ${r.passage.title}`);
    if (!APPLY && r.created.length) {
      const show = args.includes("--verbose") ? r.created : r.created.slice(0, 1);
      for (const s of show) {
        console.log(`     [${s.topic}] ${s.prompt}`);
        for (const c of s.choices) {
          console.log(`        ${c.key === s.correct_answer ? "✔" : " "} ${c.key}. ${c.text}`);
        }
        console.log(`        해설: ${s.explanation}`);
      }
    }
  }
}

console.log(`\n${APPLY ? "생성·저장" : "생성(미저장)"} ${made}개 · 부족/실패 지문 ${short}개`);
if (!APPLY) console.log("반영하려면 --apply");
