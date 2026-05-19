# thinking-english — Phase 1 설계

## 한 줄 요약
**김대휘 대표 사고력 영어 메소드를 시스템화한 듀얼모드(학원/B2C) SaaS**의 Phase 1.
3~4주 안에 "메소드의 정수"가 작동하는 상태를 목표로 한다.

## Phase 1 범위
| ID | 모듈 | 분류 |
|----|------|------|
| INF1 | 듀얼 로그인 + 멀티테넌트 인프라 | 인프라 |
| INF2 | 콘텐츠 권한 구조 (공용/사설) | 인프라 |
| S1 | Gist 노트테이커 | 학생 |
| S2 | 역방향 재구성 + Claude 채점 | 학생 |
| T4 | 학생 진도 대시보드 (최소) | 원장 |

Phase 1 끝에 학원 원장은 학생들의 Gist 작업 진도와 재구성 점수를 한눈에 볼 수 있고, B2C 학생은 자력으로 같은 훈련을 할 수 있어야 한다.

---

## 기술 스택
- **Next.js 14** (App Router, RSC 우선)
- **Supabase** (Auth, Postgres, RLS, Storage)
- **Claude API** (Haiku 4.5 + Sonnet 4.6 믹스, Prompt Caching)
- **Tailwind CSS + shadcn/ui**
- **Vercel** 배포

## 환경 변수
```
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=
ANTHROPIC_API_KEY=
```

---

## 데이터 모델 (Phase 1)

```sql
-- 조직(학원). B2C 개인은 org 없음 (NULL)
create table te_organizations (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  invite_code text unique not null,           -- 학생 가입용 학원 코드
  subscription_status text default 'trial',
  created_at timestamptz default now()
);

-- 모든 사용자 (Supabase auth.users 확장)
create table te_profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text not null,
  display_name text,
  role text not null check (role in ('director','instructor','student','b2c')),
  org_id uuid references te_organizations(id),    -- B2C는 NULL
  grade_level smallint,                        -- 7~12 (중1~고3)
  level_tier text check (level_tier in ('low','mid','high','elite')),
  created_at timestamptz default now()
);

-- 지문 (콘텐츠)
create table te_passages (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  body text not null,                          -- 영어 본문
  source text,                                 -- 교과서/모의고사/외부 등
  grade_level smallint,
  difficulty text check (difficulty in ('low','mid','high','elite')),
  org_id uuid references te_organizations(id),    -- NULL이면 공용
  created_by uuid references te_profiles(id),
  created_at timestamptz default now()
);

-- 단락 (지문을 단락 단위로 자른 것)
create table te_paragraphs (
  id uuid primary key default gen_random_uuid(),
  passage_id uuid not null references te_passages(id) on delete cascade,
  ord smallint not null,                       -- 단락 순서 0,1,2..
  body text not null,
  unique(passage_id, ord)
);

-- 학생의 Gist 노트
create table te_gist_notes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references te_profiles(id) on delete cascade,
  paragraph_id uuid not null references te_paragraphs(id) on delete cascade,
  main_idea_text text,                         -- 메인 아이디어로 선택한 문장
  supporting_text text,                        -- 서포팅 센텐스로 선택한 문장
  main_idea_offset jsonb,                      -- {start, end} - 본문 내 위치
  supporting_offset jsonb,
  updated_at timestamptz default now(),
  unique(user_id, paragraph_id)                -- 단락당 하나
);

-- 역방향 재구성 시도
create table te_reconstruction_attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references te_profiles(id) on delete cascade,
  paragraph_id uuid not null references te_paragraphs(id) on delete cascade,
  gist_note_id uuid references te_gist_notes(id),
  student_text text not null,                  -- 학생이 재구성한 글
  ai_score smallint,                           -- 0-100
  ai_feedback jsonb,                           -- {strengths, weaknesses, suggestions}
  ai_model text,                               -- 어느 모델 썼는지
  created_at timestamptz default now()
);

-- 학생 진도 (집계용)
create table te_student_progress (
  user_id uuid primary key references te_profiles(id) on delete cascade,
  total_paragraphs_attempted int default 0,
  total_gist_notes int default 0,
  total_reconstructions int default 0,
  avg_reconstruction_score numeric,
  last_active_at timestamptz
);
```

### RLS (Row-Level Security) 핵심 규칙
- `te_passages`, `te_paragraphs`: 사용자가 `org_id == te_passages.org_id` 이거나 `te_passages.org_id IS NULL` (공용) 일 때 읽기 가능
- `te_gist_notes`, `te_reconstruction_attempts`: 본인 것만 읽기/쓰기. 단 같은 org의 instructor/director는 읽기 가능
- `te_profiles`: 본인 것 읽기/쓰기. 같은 org의 instructor/director는 학생 프로필 읽기 가능
- `te_organizations`: 멤버만 읽기, director만 수정

---

## 인증 흐름

### 가입 분기
```
[가입 화면]
 ├─ "학원 코드 있어요" 탭
 │   → 학원 코드 입력 → org 조회
 │   → 이메일/비번 가입 → profile.role='student', profile.org_id=조회된 org
 │
 └─ "혼자 공부할게요" 탭
     → 이메일/비번 가입 → profile.role='b2c', profile.org_id=NULL
```

### 로그인 후 라우팅
```
/login → 인증 성공 시 profile.role 기준으로 분기
  director  → /academy/dashboard
  instructor→ /academy/dashboard
  student   → /learn (학원 소속)
  b2c       → /learn (개인)
```

`/learn` 화면은 학원 소속과 B2C가 동일한 학습 UI를 쓰되, 보여지는 콘텐츠 범위만 다름 (RLS로 제어).

### 학원 셋업 (Phase 1 초기엔 수동)
- 새 학원 만들기는 Phase 1에서는 관리자(나)가 직접 Supabase에 row 삽입 + invite_code 발급
- 정식 자가 셋업 UI는 Phase 3에서

---

## 핵심 화면 흐름

### 학생: Gist 훈련 한 사이클

```
1. /learn/te_passages
   └ 지문 목록 (난이도/학년 필터)

2. /learn/te_passages/[id]
   └ 지문 본문 + 단락별 진행 상태 (Gist 노트 작성 여부 표시)

3. /learn/te_paragraphs/[id]/gist
   └ 단락 본문 표시
   └ 학생은 두 문장을 클릭/드래그로 지정:
      - "메인 아이디어" (노란 형광펜)
      - "서포팅 센텐스" (파란 밑줄)
   └ 저장 → te_gist_notes 테이블에 기록

4. /learn/te_paragraphs/[id]/reconstruct
   └ 학생의 두 문장만 카드로 표시 (본문 가림)
   └ 입력 칸: "이 두 문장으로 단락 전체 내용을 다시 써보세요"
   └ 제출 → Claude API → 점수+피드백 → te_reconstruction_attempts 저장
   └ 결과 화면: 점수, 강점/약점, 개선 제안, 원문 비교
```

### 원장: 진도 대시보드

```
/academy/dashboard
 └ 소속 학생 목록 (이름, 학년, 레벨, 활성도)
 └ 학생별 클릭 → 상세

/academy/students/[id]
 └ 그래프: 일별 Gist 노트 수, 재구성 점수 추이
 └ 최근 재구성 시도 리스트 (점수, AI 피드백 요약)
 └ 약점 자동 태깅 (Phase 2에서 자동화, Phase 1은 점수 분포만)
```

---

## Claude 채점 프롬프트 설계 (S2)

### 시스템 프롬프트 (캐시 대상)
```
역할: 한국 중·고등학생 영어 학습 채점관.
임무: 학생이 영어 단락의 메인+서포팅 문장 2개만 보고
       단락 전체 내용을 자기 말로 재구성한 글을 평가.

평가 기준 (각 0~25점, 합계 100점):
1. 핵심 메시지 일치도 (Main Idea Fidelity)
2. 서포팅 디테일 반영 (Supporting Detail)
3. 논리 흐름 (Logical Flow)
4. 영어 표현 정확성 (Language Accuracy)

출력: JSON
{
  "score": 0-100,
  "subscores": {"main":x, "support":x, "flow":x, "language":x},
  "strengths": ["..."],   // 1~3개
  "weaknesses": ["..."],  // 1~3개
  "suggestions": ["..."], // 다음 단계 개선 행동 1~3개
  "rewritten_example": "..."  // 학생 글을 다듬은 모범 예시
}

원칙:
- 학생의 사고 노력을 보고, 영어 표면 오류만으로 점수 깎지 말 것
- 피드백은 한국어로 (중·고생이 읽음)
- 모범 예시는 학생 수준에 맞는 영어로
```

### 사용자 메시지 (캐시 안 됨, 매번 다름)
```
원문 단락:
"""
{paragraph.body}
"""

학생이 추출한 두 문장:
- 메인 아이디어: "{gist.main_idea_text}"
- 서포팅 센텐스: "{gist.supporting_text}"

학생의 재구성 글:
"""
{student_text}
"""

위 학생의 재구성을 평가해 주세요.
```

### 모델 라우팅
- **Haiku 4.5**: 1차 채점. 빠르고 저렴
- **Sonnet 4.6**: 학생/원장이 "재채점 요청" 누른 경우, 또는 Haiku 점수가 애매한 구간(40~70점)일 때 자동 승급

### 비용 추정
- Haiku 4.5: 시스템 프롬프트(~500토큰) 캐시 + 매번 사용자 메시지(~800토큰) + 응답(~400토큰)
- 캐시 적용 시: 입력 약 $0.0001 + 출력 $0.002 ≈ 채점 1건 ~3원
- 100명 학원 × 월 30회 = 9,000원

---

## 폴더 구조 (예정)
```
thinking-english/
├── app/
│   ├── (auth)/login/page.tsx
│   ├── (auth)/signup/page.tsx
│   ├── learn/
│   │   ├── te_passages/page.tsx
│   │   ├── te_passages/[id]/page.tsx
│   │   └── te_paragraphs/[id]/
│   │       ├── gist/page.tsx
│   │       └── reconstruct/page.tsx
│   ├── academy/
│   │   ├── dashboard/page.tsx
│   │   └── students/[id]/page.tsx
│   └── api/
│       └── grade/reconstruction/route.ts
├── lib/
│   ├── supabase/client.ts
│   ├── supabase/server.ts
│   ├── claude/client.ts
│   └── claude/grade-reconstruction.ts
├── components/
│   ├── GistEditor.tsx           -- 문장 하이라이트 도구
│   ├── ReconstructionForm.tsx
│   └── academy/StudentList.tsx
├── docs/
│   └── PHASE-1-DESIGN.md
└── supabase/
    └── migrations/
        └── 0001_phase1_schema.sql
```

---

## Phase 1 완료 체크리스트
- [ ] Supabase 프로젝트 생성, 스키마 + RLS 적용
- [ ] Next.js 프로젝트 스캐폴딩
- [ ] 듀얼 로그인 (학원 코드 / B2C) 동작
- [ ] 샘플 지문 3개 등록 (단락 분리 포함)
- [ ] S1: Gist 노트테이커 — 문장 클릭으로 하이라이트, 저장, 불러오기
- [ ] S2: 역방향 재구성 — 입력 → Claude 채점 → 결과 표시
- [ ] T4: 학원 대시보드 — 학생 진도/점수 추이
- [ ] Vercel 배포, 도메인 연결 (`thinking-english.vercel.app` 우선)

---

## 결정해야 할 추가 항목
1. **지문 등록 방식**: Phase 1에서는 직접 SQL/대시보드로 넣을지, 간단한 업로드 UI 만들지?
   - 추천: 직접 SQL (3개 정도면 빠름)
2. **샘플 지문 출처**: 어디서 가져올지?
   - 추천: 공개된 EBS 모의고사 또는 영자 신문 무료 단락
3. **무료 평가판 기간**: 학원 trial 며칠?
   - Phase 1은 신경 안 써도 됨 (결제 Phase 3)
4. **언어**: UI는 한국어, 학습 콘텐츠는 영어 (확정)
