import Link from "next/link";

export default function Home() {
  return (
    <main className="min-h-screen flex flex-col items-center justify-center px-6">
      <div className="max-w-2xl text-center space-y-8">
        <div className="space-y-3">
          <h1 className="text-5xl font-bold tracking-tight">
            Thinking <span className="text-brand-600">English</span>
          </h1>
          <p className="text-xl text-gray-600">
            암기를 넘어, 생각하면서 읽는 영어
          </p>
        </div>

        <div className="space-y-2 text-gray-700">
          <p>지문에서 핵심을 뽑아내는 <b>Gist 노트테이킹</b>,</p>
          <p>두 문장만 보고 단락을 다시 쓰는 <b>역방향 재구성</b>으로</p>
          <p>학생의 <b>증거 기반 사고력</b>을 훈련합니다.</p>
        </div>

        <div className="flex gap-3 justify-center pt-4">
          <Link
            href="/login"
            className="px-6 py-3 rounded-md bg-brand-600 text-white font-semibold hover:bg-brand-700 transition"
          >
            로그인
          </Link>
          <Link
            href="/signup"
            className="px-6 py-3 rounded-md border border-brand-600 text-brand-700 font-semibold hover:bg-brand-50 transition"
          >
            가입하기
          </Link>
        </div>
      </div>
    </main>
  );
}
