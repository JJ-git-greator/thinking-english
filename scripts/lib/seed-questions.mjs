import fs from "fs";
import path from "path";

/** .env.local 로더 (스크립트 공용) */
export function loadEnv(root = process.cwd()) {
  const raw = fs.readFileSync(path.join(root, ".env.local"), "utf8");
  return Object.fromEntries(
    raw
      .split(/\r?\n/)
      .filter((l) => l.includes("=") && !l.trimStart().startsWith("#"))
      .map((l) => {
        const i = l.indexOf("=");
        return [l.slice(0, i).trim(), l.slice(i + 1).trim()];
      }),
  );
}

/** service_role Supabase REST 헬퍼 */
export function supa(env) {
  const base = `${env.NEXT_PUBLIC_SUPABASE_URL}/rest/v1`;
  const headers = {
    apikey: env.SUPABASE_SERVICE_ROLE_KEY,
    Authorization: `Bearer ${env.SUPABASE_SERVICE_ROLE_KEY}`,
    "Content-Type": "application/json",
  };
  return {
    async select(pathQuery) {
      const r = await fetch(`${base}/${pathQuery}`, { headers });
      const t = await r.text();
      if (!r.ok) throw new Error(`GET ${pathQuery} → ${r.status} ${t}`);
      return JSON.parse(t);
    },
    async insert(table, rows) {
      const r = await fetch(`${base}/${table}`, {
        method: "POST",
        headers: { ...headers, Prefer: "return=representation" },
        body: JSON.stringify(rows),
      });
      const t = await r.text();
      if (!r.ok) throw new Error(`POST ${table} → ${r.status} ${t}`);
      return JSON.parse(t);
    },
    async patch(table, filter, patch) {
      const r = await fetch(`${base}/${table}?${filter}`, {
        method: "PATCH",
        headers: { ...headers, Prefer: "return=minimal" },
        body: JSON.stringify(patch),
      });
      if (!r.ok) throw new Error(`PATCH ${table} → ${r.status} ${await r.text()}`);
    },
  };
}

/**
 * 시드 .sql 안의 `insert into <table> (cols) values (...),(...);` 를 파싱해
 * 컬럼명 → 값 객체 배열로 돌려준다. (문자열 안의 쉼표·괄호를 고려한 스캐너)
 */
export function parseInserts(sql, table) {
  const rows = [];
  const re = new RegExp(`insert\\s+into\\s+${table}\\s*\\(([^)]*)\\)\\s*values`, "gi");
  let m;
  while ((m = re.exec(sql)) !== null) {
    const cols = m[1].split(",").map((c) => c.trim());
    let i = re.lastIndex;
    // values 뒤부터 세미콜론(문자열 밖)까지 스캔
    let depth = 0;
    let inStr = false;
    let cur = null;
    for (; i < sql.length; i++) {
      const ch = sql[i];
      if (inStr) {
        if (ch === "'") {
          if (sql[i + 1] === "'") {
            cur += "''";
            i++;
          } else {
            inStr = false;
            cur += ch;
          }
        } else if (cur !== null) cur += ch;
        continue;
      }
      if (ch === "'") {
        inStr = true;
        if (cur !== null) cur += ch;
        continue;
      }
      if (ch === "(") {
        depth++;
        if (depth === 1) {
          cur = "";
          continue;
        }
      }
      if (ch === ")") {
        depth--;
        if (depth === 0) {
          rows.push(toObject(cols, splitTopLevel(cur)));
          cur = null;
          continue;
        }
      }
      if (ch === ";" && depth === 0) break;
      if (cur !== null) cur += ch;
    }
  }
  return rows;
}

function splitTopLevel(s) {
  const out = [];
  let cur = "";
  let inStr = false;
  for (let i = 0; i < s.length; i++) {
    const ch = s[i];
    if (inStr) {
      if (ch === "'") {
        if (s[i + 1] === "'") {
          cur += "'";
          i++;
        } else inStr = false;
      } else cur += ch;
      continue;
    }
    if (ch === "'") {
      inStr = true;
      continue;
    }
    if (ch === ",") {
      out.push(cur.trim());
      cur = "";
      continue;
    }
    cur += ch;
  }
  out.push(cur.trim());
  return out;
}

function toObject(cols, vals) {
  const o = {};
  cols.forEach((c, i) => {
    let v = vals[i];
    if (v === undefined) v = null;
    else if (/^null$/i.test(v.trim())) v = null;
    o[c] = v;
  });
  return o;
}

/** CP949↔UTF-8 깨짐(한자·낱자모 섞임) 감지 */
export function isMojibake(s) {
  return typeof s === "string" && /[一-鿿ㄱ-ㆎ]/.test(s);
}
