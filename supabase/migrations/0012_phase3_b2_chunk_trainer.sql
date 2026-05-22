-- =====================================================================
-- 직독직해 훈련 (chunk trainer)
-- 단락에서 뽑은 문장을 의미 단위로 잘라 순차 공개. 학생은 청크별 한국어 의미 떠올리기 훈련.
-- =====================================================================

create table te_chunk_sentences (
  id uuid primary key default gen_random_uuid(),
  paragraph_id uuid not null references te_paragraphs(id) on delete cascade,
  ord smallint not null,                    -- 단락 내 문장 순서 (0,1,2,...)
  full_sentence text not null,              -- 원본 영어 문장
  chunks jsonb not null,                    -- [{"en":"The viewer thinks","ko":"보는 사람은 생각한다"}, ...]
  note text,                                -- 강사 메모 (선택, 예: "주어 강조" "관계절")
  created_at timestamptz default now(),
  unique(paragraph_id, ord)
);

create index idx_chunk_sent_para on te_chunk_sentences(paragraph_id);

create table te_chunk_attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references te_profiles(id) on delete cascade,
  sentence_id uuid not null references te_chunk_sentences(id) on delete cascade,
  paragraph_id uuid not null references te_paragraphs(id) on delete cascade,
  rating smallint not null check (rating in (1,2,3)),  -- 1=다시, 2=보통, 3=익숙
  attempted_at timestamptz default now()
);

create index idx_chunk_att_user on te_chunk_attempts(user_id, attempted_at desc);
create index idx_chunk_att_para on te_chunk_attempts(paragraph_id);

-- RLS
alter table te_chunk_sentences enable row level security;
alter table te_chunk_attempts enable row level security;

-- 문장은 단락 가시성에 따름
create policy "chunk_sent_read" on te_chunk_sentences for select
  using (
    exists (
      select 1 from te_paragraphs p
      join te_passages ps on ps.id = p.passage_id
      where p.id = te_chunk_sentences.paragraph_id
        and (ps.org_id is null or ps.org_id = te_auth_org_id())
    )
  );

-- 학생 시도는 본인 + 같은 org 강사 읽기
create policy "chunk_att_self_all" on te_chunk_attempts for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

create policy "chunk_att_org_staff_read" on te_chunk_attempts for select
  using (
    te_auth_role() in ('director','instructor')
    and exists (
      select 1 from te_profiles s
      where s.id = te_chunk_attempts.user_id and s.org_id = te_auth_org_id()
    )
  );
