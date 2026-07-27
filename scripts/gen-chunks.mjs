/**
 * 직독직해 청크 증량 — 청크가 없는 단락을 채운다 (단락당 2문장).
 *
 * 안전 설계: 청크의 en 을 이어붙이면 **원문 문장과 정확히 같아야** 한다(공백만 무시).
 * 다르면 버린다 → 모델이 문장을 바꾸거나 빠뜨리는 사고를 원천 차단.
 *
 * 청크 원칙(2026-05 확정): 주어구 통째 / 동사+목적어 한 덩어리 / 부사구 별개 /
 * 종속절·관계절 통째 / 3~8 단어.
 *
 * 실행: node scripts/gen-chunks.mjs [--limit N] [--apply]
 */
import Anthropic from "@anthropic-ai/sdk";
import { loadEnv, supa } from "./lib/seed-questions.mjs";

const args = process.argv.slice(2);
const APPLY = args.includes("--apply");
const LIMIT = (() => {
  const i = args.indexOf("--limit");
  return i === -1 ? Infinity : Number(args[i + 1]);
})();
const PER_PARAGRAPH = 2;
const MODEL = "claude-sonnet-4-6";
const CONCURRENCY = 4;

const env = loadEnv(process.cwd());
const db = supa(env);
const claude = new Anthropic({ apiKey: env.ANTHROPIC_API_KEY });

const SYSTEM = `역할: 영어 문장을 직독직해(왼쪽부터 끊어 읽기)용 의미 단위로 자르는 도구.

학생은 영어 어순 그대로 왼쪽부터 읽으며 청크마다 한국어 의미를 떠올린다. 되돌아가지 않는다.

자르는 원칙
- 주어구는 통째로 (수식어 포함)
- 동사 + 목적어는 한 덩어리 (동사만 따로 자르지 마라)
- 부사구·전치사구는 별개 청크
- 종속절·관계절은 통째로 한 청크
- 목표 3~8 단어/청크. 2단어 이하로 잘게 쪼개지 마라.

한국어(ko)
- 영어 어순 그대로, 그 청크까지 읽었을 때 떠올릴 의미를 자연스러운 한국어로.
- 문장 전체를 매끄럽게 다듬은 번역이 아니라 **그 덩어리의 의미**만 쓴다.

절대 규칙
- en 을 순서대로 이어 붙이면 **원문 문장과 글자 하나까지 같아야** 한다.
  단어를 바꾸거나 빼거나 추가하지 마라. 구두점도 원문 그대로 둔다.
- note 는 이 문장에서 학생이 알아둘 구조 힌트 한 줄(한국어, 20자 내외). 없으면 빈 문자열.

출력: 오직 JSON 배열.
[{"index":0,"chunks":[{"en":"...","ko":"..."}],"note":"..."}]`;

const flat = (s) => String(s).replace(/\s+/g, " ").trim();

function splitSentences(body) {
  return (body.match(/[^.!?]+[.!?]+(?:["')\]]+)?(?=\s|$)/g) ?? [body])
    .map((s) => s.trim())
    .filter(Boolean);
}

async function generateForParagraph(p) {
  const candidates = p.sentences.filter((s) => s.split(/\s+/).length >= 7);
  if (!candidates.length) return { paragraph: p, created: [], note: "짧은 문장뿐" };

  const userText = [
    "단락:",
    p.body,
    "",
    "문장 후보:",
    ...candidates.map((s, i) => `${i}. ${s}`),
    "",
    `이 중 앞에서부터 ${Math.min(PER_PARAGRAPH, candidates.length)}개 문장을 청크로 잘라 JSON 배열로만 출력.`,
  ].join("\n");

  const resp = await claude.messages.create({
    model: MODEL,
    max_tokens: 2000,
    system: [{ type: "text", text: SYSTEM, cache_control: { type: "ephemeral" } }],
    messages: [{ role: "user", content: userText }],
  });
  const raw = resp.content.map((b) => (b.type === "text" ? b.text : "")).join("");
  let picks = [];
  try {
    picks = JSON.parse(raw.slice(raw.indexOf("["), raw.lastIndexOf("]") + 1));
  } catch {
    picks = [];
  }

  const rows = [];
  const rejects = [];
  let ord = 0;
  for (const pick of picks) {
    if (rows.length >= PER_PARAGRAPH) break;
    const sentence = candidates[Number(pick.index)];
    const chunks = Array.isArray(pick.chunks) ? pick.chunks : [];
    if (!sentence || chunks.length < 2) {
      rejects.push("문장 번호 또는 청크 부족");
      continue;
    }
    const joined = flat(chunks.map((c) => c.en).join(" "));
    if (joined !== flat(sentence)) {
      rejects.push(`이어붙인 결과가 원문과 다름: ${joined.slice(0, 60)}`);
      continue;
    }
    if (!chunks.every((c) => /[가-힣]/.test(String(c.ko ?? "")))) {
      rejects.push("한국어 없는 청크");
      continue;
    }
    rows.push({
      paragraph_id: p.id,
      ord: ord++,
      full_sentence: sentence,
      chunks: chunks.map((c) => ({ en: String(c.en), ko: String(c.ko).trim() })),
      note: pick.note ? String(pick.note).slice(0, 60) : null,
    });
  }

  if (APPLY && rows.length) await db.insert("te_chunk_sentences", rows);
  return { paragraph: p, created: rows, rejects };
}

// ── 실행 ────────────────────────────────────────────────────────────────────
const paragraphs = await db.select(
  "te_paragraphs?select=id,ord,body,passage_id&order=passage_id,ord&limit=2000",
);
const existing = await db.select("te_chunk_sentences?select=paragraph_id&limit=5000");
const passages = await db.select("te_passages?select=id,title&limit=200");
const titleBy = new Map(passages.map((p) => [p.id, p.title]));
const has = new Set(existing.map((c) => c.paragraph_id));

const targets = paragraphs
  .filter((p) => !has.has(p.id))
  .map((p) => ({ ...p, sentences: splitSentences(p.body), title: titleBy.get(p.passage_id) }))
  .slice(0, LIMIT);

console.log(`청크 없는 단락 ${targets.length}개 · ${APPLY ? "APPLY" : "DRY-RUN"}\n`);

let made = 0;
for (let i = 0; i < targets.length; i += CONCURRENCY) {
  const batch = targets.slice(i, i + CONCURRENCY);
  const results = await Promise.all(
    batch.map((p) =>
      generateForParagraph(p).catch((e) => ({ paragraph: p, created: [], error: String(e).slice(0, 100) })),
    ),
  );
  for (const r of results) {
    made += r.created.length;
    console.log(
      `${r.error ? "❌ " + r.error : `+${r.created.length}`}  ${r.paragraph.title} · 단락 ${r.paragraph.ord + 1}${r.note ? " · " + r.note : ""}`,
    );
    if (!APPLY) {
      for (const row of r.created) {
        console.log(`     ${row.chunks.map((c) => `[${c.en} → ${c.ko}]`).join(" ")}`);
      }
      for (const rej of r.rejects ?? []) console.log(`     ✗ ${rej}`);
    }
  }
}
console.log(`\n${APPLY ? "저장" : "생성(미저장)"} ${made}문장`);
if (!APPLY) console.log("반영하려면 --apply");
