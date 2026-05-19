"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { LEVEL_LABELS, type LevelTier } from "@/lib/leveling";

interface Props {
  studentId: string;
  initial: LevelTier | null;
}

export default function LevelEditor({ studentId, initial }: Props) {
  const router = useRouter();
  const supabase = createClient();
  const [level, setLevel] = useState<LevelTier | "">(initial ?? "");
  const [saving, setSaving] = useState(false);
  const [savedAt, setSavedAt] = useState<Date | null>(null);
  const [error, setError] = useState<string | null>(null);

  async function handleSave() {
    setSaving(true);
    setError(null);
    const { error: upErr } = await supabase
      .from("te_profiles")
      .update({ level_tier: level === "" ? null : level })
      .eq("id", studentId);
    if (upErr) {
      setError(upErr.message);
      setSaving(false);
      return;
    }
    setSavedAt(new Date());
    setSaving(false);
    router.refresh();
  }

  return (
    <div className="bg-white border rounded-lg p-5 space-y-3">
      <div>
        <h3 className="font-semibold text-gray-900">학생 레벨</h3>
        <p className="text-sm text-gray-500 mt-1">
          레벨에 따라 학생이 풀 수 있는 문제 카테고리·난이도가 자동으로 잠깁니다.
          (강의 라인 549~676: "4등급 학생은 30번 안쪽만")
        </p>
      </div>

      <div className="grid grid-cols-4 gap-2">
        {(["low", "mid", "high", "elite"] as LevelTier[]).map((t) => (
          <button
            key={t}
            onClick={() => setLevel(t)}
            className={`py-2 rounded-md border text-sm font-medium transition ${
              level === t
                ? "bg-brand-600 text-white border-brand-600"
                : "bg-white text-gray-700 border-gray-200 hover:bg-gray-50"
            }`}
          >
            {LEVEL_LABELS[t]}
          </button>
        ))}
      </div>

      <button
        onClick={() => setLevel("")}
        className="text-xs text-gray-500 hover:text-gray-900"
      >
        레벨 미설정으로 되돌리기 (기본 중으로 작동)
      </button>

      <div className="text-xs text-gray-600 space-y-0.5">
        <p>
          <b>하</b>: 주제 찾기만 (지스트 30번 안쪽 정신)
        </p>
        <p>
          <b>중</b>: 주제 + 어휘
        </p>
        <p>
          <b>상</b>: 주제 + 빈칸 + 어휘
        </p>
        <p>
          <b>극상</b>: 전체 + 어법
        </p>
      </div>

      {error && (
        <div className="text-sm text-red-600 bg-red-50 border border-red-200 rounded-md p-2">
          {error}
        </div>
      )}

      <div className="flex items-center gap-3">
        <button
          onClick={handleSave}
          disabled={saving}
          className="px-4 py-2 rounded-md bg-brand-600 text-white font-medium hover:bg-brand-700 disabled:opacity-50"
        >
          {saving ? "저장 중..." : "저장"}
        </button>
        {savedAt && (
          <span className="text-sm text-gray-500">
            저장됨 ({savedAt.toLocaleTimeString("ko-KR")})
          </span>
        )}
      </div>
    </div>
  );
}
