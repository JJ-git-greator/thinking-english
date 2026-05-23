-- =====================================================================
-- B2.5 주어·동사 찾기 드릴
-- 복잡한 문장에서 주어/동사를 단어 단위로 클릭해 즉시 찾아내는 반사 훈련
-- =====================================================================

create table te_sv_drill_sentences (
  id uuid primary key default gen_random_uuid(),
  passage_id uuid not null references te_passages(id) on delete cascade,
  difficulty text not null check (difficulty in ('low','mid','high','elite')),
  ord smallint not null,
  full_sentence text not null,
  tokens jsonb not null,                          -- ["The","viewer","thinks,",...] 공백 분리
  subject_start smallint not null,                 -- 주어구 시작 토큰 idx
  subject_end smallint not null,                   -- 주어구 끝 토큰 idx (포함)
  verb_start smallint not null,
  verb_end smallint not null,
  created_at timestamptz default now()
);

create index idx_sv_sent_difficulty on te_sv_drill_sentences(difficulty);
create index idx_sv_sent_passage on te_sv_drill_sentences(passage_id);

create table te_sv_drill_attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references te_profiles(id) on delete cascade,
  sentence_id uuid not null references te_sv_drill_sentences(id) on delete cascade,
  kind text not null check (kind in ('subject','verb')),
  is_correct boolean not null,
  elapsed_ms int,
  attempted_at timestamptz default now()
);

create index idx_sv_att_user on te_sv_drill_attempts(user_id, attempted_at desc);

-- RLS
alter table te_sv_drill_sentences enable row level security;
alter table te_sv_drill_attempts enable row level security;

create policy "sv_sent_read" on te_sv_drill_sentences for select
  using (
    exists (
      select 1 from te_passages ps
      where ps.id = te_sv_drill_sentences.passage_id
        and (ps.org_id is null or ps.org_id = te_auth_org_id())
    )
  );

create policy "sv_att_self_all" on te_sv_drill_attempts for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

create policy "sv_att_org_staff_read" on te_sv_drill_attempts for select
  using (
    te_auth_role() in ('director','instructor')
    and exists (
      select 1 from te_profiles s
      where s.id = te_sv_drill_attempts.user_id and s.org_id = te_auth_org_id()
    )
  );
