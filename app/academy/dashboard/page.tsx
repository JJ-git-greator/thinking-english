import Link from "next/link";
import { createClient } from "@/lib/supabase/server";

export default async function DashboardPage() {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  const userId = userResp.user!.id;

  const { data: me } = await supabase
    .from("te_profiles")
    .select("org_id")
    .eq("id", userId)
    .single();

  // All students in this org
  const { data: students } = await supabase
    .from("te_profiles")
    .select("id, display_name, grade_level, level_tier, created_at")
    .eq("org_id", me!.org_id)
    .eq("role", "student");

  const studentIds = (students ?? []).map((s) => s.id);

  const { data: progress } = await supabase
    .from("te_student_progress")
    .select(
      "user_id, total_gist_notes, total_reconstructions, avg_reconstruction_score, total_quiz_sessions, total_questions_answered, total_questions_correct, last_active_at",
    )
    .in("user_id", studentIds);

  const progByUser = new Map<string, NonNullable<typeof progress>[number]>();
  for (const p of progress ?? []) progByUser.set(p.user_id, p);

  // Class-wide stats
  const totalStudents = students?.length ?? 0;
  const activeIn7d = (progress ?? []).filter(
    (p) =>
      p.last_active_at &&
      Date.now() - new Date(p.last_active_at).getTime() < 7 * 86400_000,
  ).length;
  const avgScore = computeAvg(
    (progress ?? [])
      .map((p) => p.avg_reconstruction_score)
      .filter((s): s is number => typeof s === "number"),
  );

  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-3xl font-bold">진도 대시보드</h1>
        <p className="text-gray-500 mt-1">학생들의 Gist 작업과 재구성 점수를 한눈에</p>
      </div>

      <div className="grid grid-cols-3 gap-4">
        <StatCard label="등록 학생" value={`${totalStudents}명`} />
        <StatCard label="최근 7일 활성" value={`${activeIn7d}명`} />
        <StatCard
          label="반 평균 재구성 점수"
          value={avgScore !== null ? `${avgScore.toFixed(1)}점` : "—"}
        />
      </div>

      <div className="bg-white border rounded-lg overflow-hidden">
        <table className="w-full text-sm">
          <thead className="bg-gray-50 text-gray-600">
            <tr>
              <th className="text-left px-5 py-3 font-medium">이름</th>
              <th className="text-left px-5 py-3 font-medium">학년</th>
              <th className="text-left px-5 py-3 font-medium">레벨</th>
              <th className="text-right px-5 py-3 font-medium">Gist</th>
              <th className="text-right px-5 py-3 font-medium">재구성</th>
              <th className="text-right px-5 py-3 font-medium">재구성 평균</th>
              <th className="text-right px-5 py-3 font-medium">퀴즈 세션</th>
              <th className="text-right px-5 py-3 font-medium">퀴즈 정답률</th>
              <th className="text-right px-5 py-3 font-medium">최근 활동</th>
            </tr>
          </thead>
          <tbody>
            {(students ?? []).map((s) => {
              const p = progByUser.get(s.id);
              return (
                <tr key={s.id} className="border-t hover:bg-gray-50">
                  <td className="px-5 py-3 font-medium">
                    <Link
                      href={`/academy/students/${s.id}`}
                      className="hover:text-brand-600"
                    >
                      {s.display_name ?? "(이름 없음)"}
                    </Link>
                  </td>
                  <td className="px-5 py-3 text-gray-600">
                    {s.grade_level
                      ? s.grade_level <= 9
                        ? `중${s.grade_level - 6}`
                        : `고${s.grade_level - 9}`
                      : "—"}
                  </td>
                  <td className="px-5 py-3">
                    {s.level_tier ? <TierBadge tier={s.level_tier} /> : "—"}
                  </td>
                  <td className="px-5 py-3 text-right">{p?.total_gist_notes ?? 0}</td>
                  <td className="px-5 py-3 text-right">
                    {p?.total_reconstructions ?? 0}
                  </td>
                  <td className="px-5 py-3 text-right">
                    {p?.avg_reconstruction_score != null
                      ? `${Number(p.avg_reconstruction_score).toFixed(1)}`
                      : "—"}
                  </td>
                  <td className="px-5 py-3 text-right">
                    {p?.total_quiz_sessions ?? 0}
                  </td>
                  <td className="px-5 py-3 text-right">
                    {p?.total_questions_answered
                      ? `${Math.round(((p.total_questions_correct ?? 0) / p.total_questions_answered) * 100)}%`
                      : "—"}
                  </td>
                  <td className="px-5 py-3 text-right text-gray-500">
                    {p?.last_active_at
                      ? new Date(p.last_active_at).toLocaleDateString("ko-KR")
                      : "—"}
                  </td>
                </tr>
              );
            })}
            {(!students || students.length === 0) && (
              <tr>
                <td
                  colSpan={9}
                  className="text-center py-12 text-gray-400"
                >
                  아직 등록된 학생이 없습니다. 학원 초대 코드를 학생들에게 공유해 주세요.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}

function StatCard({ label, value }: { label: string; value: string }) {
  return (
    <div className="bg-white border rounded-lg p-5">
      <div className="text-sm text-gray-500">{label}</div>
      <div className="text-2xl font-bold mt-1">{value}</div>
    </div>
  );
}

function TierBadge({ tier }: { tier: string }) {
  const map: Record<string, string> = {
    low: "bg-green-100 text-green-800",
    mid: "bg-yellow-100 text-yellow-800",
    high: "bg-orange-100 text-orange-800",
    elite: "bg-red-100 text-red-800",
  };
  const label: Record<string, string> = {
    low: "하",
    mid: "중",
    high: "상",
    elite: "극상",
  };
  return (
    <span className={`text-xs px-2 py-0.5 rounded-full font-medium ${map[tier]}`}>
      {label[tier]}
    </span>
  );
}

function computeAvg(arr: number[]): number | null {
  if (!arr.length) return null;
  return arr.reduce((a, b) => a + b, 0) / arr.length;
}
