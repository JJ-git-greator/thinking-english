-- =====================================================================
-- Structure 2회독: 자유 텍스트 메모 → 객관식 풀이로 전환
-- 단락별 사전 작성된 객관식 (주어/동사/구조) 3문제 + 학생 답안 기록
-- =====================================================================

create table te_structure_questions (
  id uuid primary key default gen_random_uuid(),
  paragraph_id uuid not null references te_paragraphs(id) on delete cascade,
  ord smallint not null,                    -- 단락 내 문제 순서 (0,1,2)
  kind text not null check (kind in ('subject','verb','structure')),
  prompt text not null,                      -- 한국어 질문
  target_sentence text,                      -- 어느 영어 문장에 대한 질문인지 (인용)
  choices jsonb not null,                    -- [{"key":"1","text":"..."}, ...]
  correct_answer text not null,              -- "1", "2", ...
  explanation text,                          -- 한국어 해설
  created_at timestamptz default now(),
  unique(paragraph_id, ord)
);

create index idx_struct_q_para on te_structure_questions(paragraph_id);

create table te_structure_attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references te_profiles(id) on delete cascade,
  question_id uuid not null references te_structure_questions(id) on delete cascade,
  paragraph_id uuid not null references te_paragraphs(id) on delete cascade,
  chosen_answer text not null,
  is_correct boolean not null,
  answered_at timestamptz default now()
);

create index idx_struct_att_user on te_structure_attempts(user_id, answered_at desc);
create index idx_struct_att_para on te_structure_attempts(paragraph_id);

-- RLS
alter table te_structure_questions enable row level security;
alter table te_structure_attempts enable row level security;

-- 문제는 단락 가시성에 따라 자동
create policy "struct_q_read" on te_structure_questions for select
  using (
    exists (
      select 1 from te_paragraphs p
      join te_passages ps on ps.id = p.passage_id
      where p.id = te_structure_questions.paragraph_id
        and (ps.org_id is null or ps.org_id = te_auth_org_id())
    )
  );

-- 학생 답안은 본인만 + 같은 org 강사 읽기
create policy "struct_att_self_all" on te_structure_attempts for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

create policy "struct_att_org_staff_read" on te_structure_attempts for select
  using (
    te_auth_role() in ('director','instructor')
    and exists (
      select 1 from te_profiles s
      where s.id = te_structure_attempts.user_id and s.org_id = te_auth_org_id()
    )
  );
