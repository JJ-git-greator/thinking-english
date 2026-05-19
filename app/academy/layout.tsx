import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";

export default async function AcademyLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) redirect("/login");

  const { data: profile } = await supabase
    .from("te_profiles")
    .select("display_name, role, org_id, te_organizations(name)")
    .eq("id", userResp.user.id)
    .maybeSingle();

  if (!profile || (profile.role !== "director" && profile.role !== "instructor")) {
    redirect("/learn/passages");
  }

  const org = Array.isArray(profile.te_organizations)
    ? profile.te_organizations[0]
    : profile.te_organizations;

  return (
    <div className="min-h-screen">
      <header className="border-b bg-white">
        <div className="max-w-6xl mx-auto px-6 py-4 flex items-center justify-between">
          <div className="flex items-center gap-6">
            <Link href="/academy/dashboard" className="font-bold text-lg">
              Thinking <span className="text-brand-600">English</span>
              <span className="ml-2 text-xs font-medium text-gray-500 align-middle">
                원장 대시보드
              </span>
            </Link>
            <nav className="flex gap-4 text-sm text-gray-600">
              <Link href="/academy/dashboard" className="hover:text-gray-900">
                대시보드
              </Link>
              <Link href="/academy/library" className="hover:text-gray-900">
                라이브러리
              </Link>
            </nav>
          </div>
          <div className="flex items-center gap-4 text-sm">
            <span className="text-gray-600">
              {org?.name} · {profile.display_name}
            </span>
            <form action="/api/logout" method="post">
              <button className="text-gray-500 hover:text-gray-900">로그아웃</button>
            </form>
          </div>
        </div>
      </header>
      <main className="max-w-6xl mx-auto px-6 py-8">{children}</main>
    </div>
  );
}
