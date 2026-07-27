/**
 * 주어·동사 찾기 드릴 문장 증량 — 지문당 목표 3문장.
 *
 * 안전 설계: 문장을 모델이 새로 쓰지 않는다. 지문에서 뽑은 실제 문장 후보를 번호로 주고,
 * 모델은 (문장 번호 / 주어구 / 동사구)만 고른다. 주어·동사 토큰 위치는 **코드가 계산**하고,
 * 원문 토큰과 정확히 일치하지 않으면 버린다. → 좌표 오류·환각 원천 차단.
 *
 * 실행:
 *   node scripts/gen-sv-drill.mjs --limit 2          # dry-run
 *   node scripts/gen-sv-drill.mjs --apply
 */
import Anthropic from "@anthropic-ai/sdk";
import { loadEnv, supa } from "./lib/seed-questions.mjs";

const args = process.argv.slice(2);
const APPLY = args.includes("--apply");
const LIMIT = flagNum("--limit", Infinity);
const TARGET = flagNum("--target", 3);
const MODEL = "claude-sonnet-4-6";
const CONCURRENCY = 4;

function flagNum(f, d) {
  const i = args.indexOf(f);
  return i === -1 ? d : Number(args[i + 1]);
}

const env = loadEnv(process.cwd());
const db = supa(env);
const claude = new Anthropic({ apiKey: env.ANTHROPIC_API_KEY });

const SYSTEM = `역할: 영어 문장의 뼈대(주어·동사)를 표시하는 문법 분석기.

주어진 번호 매긴 영어 문장들 중에서 "주어와 동사를 찾는 훈련"에 좋은 문장을 고르고,
각 문장의 **주어구(전체)** 와 **본동사(조동사 포함)** 를 문장에서 **글자 그대로 복사**해 돌려준다.

기준
- 좋은 문장 = 주어 앞에 부사구가 붙었거나, 주어에 수식어(관계절·전치사구)가 붙어 뼈대가 한눈에 안 보이는 문장.
- subject: 관사·수식어까지 포함한 주어구 전체 (예: "The unwanted proteins in the brain").
  주어가 that절·동명사면 그 덩어리 전체.
- verb: 그 주어에 대응하는 **본동사**. 조동사·be동사가 있으면 함께 (예: "can fly", "is built", "begin").
  to부정사·분사 수식어는 동사가 아니다.
- 주어가 동사보다 앞에 있는 문장만 고른다 (도치 문장 제외).
- 문장을 고쳐 쓰지 마라. 원문 그대로의 일부만 복사한다.

출력: 오직 JSON 배열. [{"index": 3, "subject": "...", "verb": "..."}, ...]`;

const stripPunct = (t) =>
  t
    .toLowerCase()
    .replace(/^[^a-z0-9']+/, "")
    .replace(/[^a-z0-9']+$/, "");

/** 토큰 배열에서 구(phrase)의 토큰 구간을 찾는다. 못 찾으면 null */
function findRange(tokens, phrase) {
  const want = phrase.trim().split(/\s+/).map(stripPunct).filter(Boolean);
  if (!want.length) return null;
  const norm = tokens.map(stripPunct);
  for (let i = 0; i + want.length <= norm.length; i++) {
    let ok = true;
    for (let j = 0; j < want.length; j++) {
      if (norm[i + j] !== want[j]) {
        ok = false;
        break;
      }
    }
    if (ok) return [i, i + want.length - 1];
  }
  return null;
}

function splitSentences(body) {
  return (body.match(/[^.!?]+[.!?]+(?:["')\]]+)?(?=\s|$)/g) ?? [body])
    .map((s) => s.trim())
    .filter(Boolean);
}

async function generateForPassage(p) {
  const need = TARGET - p.existingCount;
  if (need <= 0) return { passage: p, created: [] };

  const candidates = p.sentences.filter((s) => {
    const n = s.split(/\s+/).length;
    return n >= 9 && n <= 40 && !p.existingSentences.has(s);
  });
  if (candidates.length === 0) return { passage: p, created: [], note: "쓸 만한 문장 없음" };

  const userText = [
    `지문: ${p.title} (난이도 ${p.difficulty})`,
    "",
    "문장 후보:",
    ...candidates.map((s, i) => `${i}. ${s}`),
    "",
    `이 중 ${Math.min(need, candidates.length)}개를 골라 JSON 배열로만 출력.`,
  ].join("\n");

  const resp = await claude.messages.create({
    model: MODEL,
    max_tokens: 1500,
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
  let ord = p.nextOrd;
  for (const pick of picks) {
    if (rows.length >= need) break;
    const sentence = candidates[Number(pick.index)];
    if (!sentence) {
      rejects.push("문장 번호 잘못됨");
      continue;
    }
    const tokens = sentence.split(/\s+/);
    const subj = findRange(tokens, String(pick.subject ?? ""));
    const verb = findRange(tokens, String(pick.verb ?? ""));
    if (!subj || !verb) {
      rejects.push(`구가 원문 토큰과 안 맞음: "${pick.subject}" / "${pick.verb}"`);
      continue;
    }
    if (subj[1] >= verb[0]) {
      rejects.push("주어가 동사보다 뒤/겹침");
      continue;
    }
    rows.push({
      passage_id: p.id,
      difficulty: p.difficulty,
      ord: ord++,
      full_sentence: sentence,
      tokens,
      subject_start: subj[0],
      subject_end: subj[1],
      verb_start: verb[0],
      verb_end: verb[1],
    });
  }

  if (APPLY && rows.length) await db.insert("te_sv_drill_sentences", rows);
  return { passage: p, created: rows, rejects };
}

// ── 실행 ────────────────────────────────────────────────────────────────────
const passages = await db.select(
  "te_passages?select=id,title,body,difficulty&order=difficulty,title&limit=200",
);
const paragraphs = await db.select("te_paragraphs?select=passage_id,ord,body&order=ord&limit=2000");
const existing = await db.select("te_sv_drill_sentences?select=passage_id,ord,full_sentence&limit=2000");

const paraBy = new Map();
for (const p of paragraphs) {
  if (!paraBy.has(p.passage_id)) paraBy.set(p.passage_id, []);
  paraBy.get(p.passage_id).push(p);
}
const svBy = new Map();
for (const s of existing) {
  if (!svBy.has(s.passage_id)) svBy.set(s.passage_id, []);
  svBy.get(s.passage_id).push(s);
}

const targets = passages
  .map((p) => {
    const sv = svBy.get(p.id) ?? [];
    const text = [p.body, ...(paraBy.get(p.id) ?? []).map((x) => x.body)].filter(Boolean).join(" ");
    return {
      ...p,
      sentences: splitSentences(text),
      existingCount: sv.length,
      existingSentences: new Set(sv.map((s) => s.full_sentence)),
      nextOrd: sv.length ? Math.max(...sv.map((s) => s.ord)) + 1 : 0,
    };
  })
  .filter((p) => p.existingCount < TARGET)
  .slice(0, LIMIT);

console.log(`대상 지문 ${targets.length}개 (목표 지문당 ${TARGET}문장) · ${APPLY ? "APPLY" : "DRY-RUN"}\n`);

let made = 0;
for (let i = 0; i < targets.length; i += CONCURRENCY) {
  const batch = targets.slice(i, i + CONCURRENCY);
  const results = await Promise.all(
    batch.map((p) => generateForPassage(p).catch((e) => ({ passage: p, created: [], error: String(e).slice(0, 100) }))),
  );
  for (const r of results) {
    made += r.created.length;
    console.log(`${r.error ? "❌ " + r.error : `+${r.created.length}`}  ${r.passage.title}${r.note ? " · " + r.note : ""}`);
    if (!APPLY) {
      for (const row of r.created) {
        const t = row.tokens;
        console.log(
          `     ${t.map((w, i) => (i >= row.subject_start && i <= row.subject_end ? `[S:${w}]` : i >= row.verb_start && i <= row.verb_end ? `[V:${w}]` : w)).join(" ")}`,
        );
      }
      for (const rej of r.rejects ?? []) console.log(`     ✗ ${rej}`);
    }
  }
}
console.log(`\n${APPLY ? "저장" : "생성(미저장)"} ${made}문장`);
if (!APPLY) console.log("반영하려면 --apply");
