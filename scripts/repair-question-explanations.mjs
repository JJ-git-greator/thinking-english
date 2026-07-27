/**
 * 운영 DB의 te_questions 한국어 해설이 인코딩 깨짐(蹂몃Ц ?듭떖…) 상태인 걸 복구한다.
 * 로컬 시드 .sql 은 UTF-8 로 멀쩡하므로, (passage_id + prompt) 로 매칭해 원문으로 되돌린다.
 *
 * 실행: node scripts/repair-question-explanations.mjs [--apply]
 *   기본은 dry-run. --apply 를 줘야 실제 UPDATE.
 */
import fs from "fs";
import path from "path";
import { loadEnv, supa, parseInserts, isMojibake } from "./lib/seed-questions.mjs";

const APPLY = process.argv.includes("--apply");
const root = process.cwd();
const env = loadEnv(root);
const db = supa(env);

// 1) 시드에서 정상 한국어 원본 수집
const seedDir = path.join(root, "supabase", "seeds");
const seedRows = [];
for (const f of fs.readdirSync(seedDir).filter((f) => f.endsWith(".sql"))) {
  const sql = fs.readFileSync(path.join(seedDir, f), "utf8");
  for (const r of parseInserts(sql, "te_questions")) seedRows.push({ ...r, _file: f });
}
console.log(`시드 문제 ${seedRows.length}개 파싱`);

const byPrompt = new Map();
const byChoice = new Map();
for (const r of seedRows) {
  if (!r.passage_id || !r.prompt) continue;
  byPrompt.set(`${r.passage_id}|${r.prompt}`, r);
  try {
    const first = JSON.parse(r.choices)[0]?.text ?? "";
    byChoice.set(`${r.passage_id}|${first}|${r.correct_answer}`, r);
  } catch {
    /* choices 파싱 실패는 무시 */
  }
}

// 2) DB에서 깨진 행 찾기
const dbRows = await db.select(
  "te_questions?select=id,passage_id,topic,prompt,choices,correct_answer,explanation&limit=2000",
);
const broken = dbRows.filter(
  (r) => isMojibake(r.explanation) || isMojibake(r.prompt) || isMojibake(JSON.stringify(r.choices)),
);
console.log(`DB 문제 ${dbRows.length}개 중 깨진 행 ${broken.length}개`);

let fixed = 0;
let unmatched = 0;
for (const r of broken) {
  const firstChoice = Array.isArray(r.choices) ? r.choices[0]?.text ?? "" : "";
  const seed =
    byPrompt.get(`${r.passage_id}|${r.prompt}`) ??
    byChoice.get(`${r.passage_id}|${firstChoice}|${r.correct_answer}`);

  if (!seed) {
    unmatched++;
    console.log(`  ✗ 매칭 실패: ${r.id} · ${String(r.prompt).slice(0, 50)}`);
    continue;
  }

  const patch = {};
  if (isMojibake(r.explanation) && seed.explanation) patch.explanation = seed.explanation;
  if (isMojibake(r.prompt) && seed.prompt) patch.prompt = seed.prompt;
  if (isMojibake(JSON.stringify(r.choices)) && seed.choices) {
    patch.choices = JSON.parse(seed.choices);
  }
  if (Object.keys(patch).length === 0) continue;

  if (APPLY) await db.patch("te_questions", `id=eq.${r.id}`, patch);
  fixed++;
  if (fixed <= 3) {
    console.log(`  ✓ ${r.id}\n     전: ${String(r.explanation).slice(0, 40)}\n     후: ${String(patch.explanation ?? r.explanation).slice(0, 40)}`);
  }
}

console.log(
  `\n${APPLY ? "복구 완료" : "DRY-RUN"} — 복구 대상 ${fixed}개 / 매칭 실패 ${unmatched}개`,
);
if (!APPLY) console.log("실제 반영하려면: node scripts/repair-question-explanations.mjs --apply");
