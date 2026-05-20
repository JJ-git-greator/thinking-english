import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import LearnNav from "./LearnNav";

export default async function LearnLayout({ children }: { children: React.ReactNode }) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) redirect("/login");

  const { data: profile } = await supabase
    .from("te_profiles")
    .select("display_name, role, org_id, grade_level")
    .eq("id", userResp.user.id)
    .maybeSingle();

  const gradeLabel = profile?.grade_level
    ? profile.grade_level <= 9
      ? `중${profile.grade_level - 6}`
      : `고${profile.grade_level - 9}`
    : null;

  return (
    <div className="min-h-screen bg-gray-50">
      <LearnNav
        displayName={profile?.display_name ?? "학생"}
        gradeLabel={gradeLabel}
        isAcademyStudent={!!profile?.org_id}
      />
      <main className="max-w-6xl mx-auto px-4 sm:px-6 py-6 sm:py-8">{children}</main>
    </div>
  );
}
