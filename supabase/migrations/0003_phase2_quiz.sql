-- =====================================================================
-- thinking-english Phase 2: 10문제 컷팅 학습기 (S3)
-- - te_questions: 문제 풀 (카테고리: main_idea / blank / vocabulary / grammar)
-- - te_quiz_sessions: 10문제 묶음 (시작/완료/오답교정 상태)
-- - te_question_attempts: 학생 답안 (선택 + 근거 + 정오 + 오답교정)
-- =====================================================================

create type te_question_topic as enum (
  'main_idea',     -- 주제·요지·제목
  'blank',         -- 빈칸 추론
  'vocabulary',    -- 어휘 (contextual)
  'grammar'        -- 어법 / Structure
);

-- ---- te_questions ---------------------------------------------------
create table te_questions (
  id uuid primary key default gen_random_uuid(),
  passage_id uuid references te_passages(id) on delete set null,  -- 기반 지문 (옵션)
  topic te_question_topic not null,
  prompt text not null,                  -- 문제 본문 (영어 또는 영어+한국어 지시문)
  choices jsonb not null,                -- [{"key":"1","text":"..."}, ...]
  correct_answer text not null,          -- "1", "2", ...
  explanation text,                       -- 정답 해설 (한국어 OK)
  difficulty te_difficulty_tier,
  grade_level smallint check (grade_level between 1 and 12),
  org_id uuid references te_organizations(id),  -- NULL = 공용
  created_by uuid references te_profiles(id),
  created_at timestamptz default now()
);

create index idx_questions_topic on te_questions(topic);
create index idx_questions_org on te_questions(org_id);

-- ---- te_quiz_sessions -----------------------------------------------
-- 10문제 단위 묶음. 한 세션 종료 후 다음 묶음 시작.
create table te_quiz_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references te_profiles(id) on delete cascade,
  topic te_question_topic not null,
  batch_size smallint not null default 10 check (batch_size between 1 and 20),
  started_at timestamptz default now(),
  completed_at timestamptz,              -- 10문제 모두 답안 제출 시 박힘
  remediation_done boolean default false, -- 모든 오답에 교정 텍스트 작성 완료 시 true
  total_correct smallint                  -- 채점 후 박힘
);

create index idx_quiz_sessions_user on te_quiz_sessions(user_id, started_at desc);

-- ---- te_question_attempts -------------------------------------------
-- 세션 내 학생의 개별 문제 답안. 세션 시작 시 미리 10개 row 생성.
create table te_question_attempts (
  id uuid primary key default gen_random_uuid(),
  session_id uuid not null references te_quiz_sessions(id) on delete cascade,
  question_id uuid not null references te_questions(id) on delete cascade,
  user_id uuid not null references te_profiles(id) on delete cascade,
  ord smallint not null,                  -- 1~10 (세션 내 순서)
  chosen_answer text,                      -- 풀기 전엔 NULL
  reason_text text,                        -- 근거 입력 (강의 핵심: "왜 이걸 골랐는지")
  is_correct boolean,                      -- 답안 제출 후 채워짐
  remediation_text text,                   -- 오답 교정 사고 텍스트 (오답일 때만)
  answered_at timestamptz,
  unique(session_id, ord)
);

create index idx_attempts_session on te_question_attempts(session_id, ord);
create index idx_attempts_user on te_question_attempts(user_id, answered_at desc);

-- =====================================================================
-- RLS Policies
-- =====================================================================

alter table te_questions enable row level security;
alter table te_quiz_sessions enable row level security;
alter table te_question_attempts enable row level security;

-- te_questions: 공용은 모두 읽기, 같은 org는 자기 org 문제 읽기, 강사/원장만 쓰기
create policy "questions_public_read" on te_questions for select
  using (org_id is null);
create policy "questions_org_read" on te_questions for select
  using (org_id is not null and org_id = te_auth_org_id());
create policy "questions_org_staff_write" on te_questions for insert
  with check (
    (org_id is null and te_auth_role() = 'director')
    or (org_id = te_auth_org_id() and te_auth_role() in ('director','instructor'))
  );
create policy "questions_org_staff_update" on te_questions for update
  using (
    (org_id is null and te_auth_role() = 'director')
    or (org_id = te_auth_org_id() and te_auth_role() in ('director','instructor'))
  );

-- te_quiz_sessions: 본인 CRUD. 같은 org 강사·원장 읽기.
create policy "quiz_sessions_self_all" on te_quiz_sessions for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());
create policy "quiz_sessions_org_staff_read" on te_quiz_sessions for select
  using (
    te_auth_role() in ('director','instructor')
    and exists (
      select 1 from te_profiles s
      where s.id = te_quiz_sessions.user_id and s.org_id = te_auth_org_id()
    )
  );

-- te_question_attempts: 본인 CRUD. 같은 org 강사·원장 읽기.
create policy "attempts_self_all" on te_question_attempts for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());
create policy "attempts_org_staff_read" on te_question_attempts for select
  using (
    te_auth_role() in ('director','instructor')
    and exists (
      select 1 from te_profiles s
      where s.id = te_question_attempts.user_id and s.org_id = te_auth_org_id()
    )
  );

-- =====================================================================
-- Extend te_student_progress with quiz stats
-- =====================================================================
alter table te_student_progress add column if not exists total_quiz_sessions int default 0;
alter table te_student_progress add column if not exists total_questions_answered int default 0;
alter table te_student_progress add column if not exists total_questions_correct int default 0;
