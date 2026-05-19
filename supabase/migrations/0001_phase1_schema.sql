-- =====================================================================
-- thinking-english Phase 1 Schema
-- Dual-mode (Academy / B2C) multi-tenant + Gist + Reconstruction
-- =====================================================================

-- ---- Enums ----------------------------------------------------------
create type te_user_role as enum ('director', 'instructor', 'student', 'b2c');
create type te_difficulty_tier as enum ('low', 'mid', 'high', 'elite');

-- ---- te_organizations --------------------------------------------------
create table te_organizations (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  invite_code text unique not null,
  subscription_status text default 'trial',
  created_at timestamptz default now()
);

-- ---- te_profiles -------------------------------------------------------
create table te_profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text not null,
  display_name text,
  role te_user_role not null default 'b2c',
  org_id uuid references te_organizations(id),
  grade_level smallint check (grade_level between 1 and 12),
  level_tier te_difficulty_tier,
  created_at timestamptz default now()
);

create index idx_profiles_org on te_profiles(org_id) where org_id is not null;

-- ---- te_passages -------------------------------------------------------
create table te_passages (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  body text not null,
  source text,
  grade_level smallint check (grade_level between 1 and 12),
  difficulty te_difficulty_tier,
  org_id uuid references te_organizations(id),       -- null = 공용
  created_by uuid references te_profiles(id),
  created_at timestamptz default now()
);

create index idx_passages_org on te_passages(org_id);
create index idx_passages_difficulty on te_passages(difficulty);

-- ---- te_paragraphs -----------------------------------------------------
create table te_paragraphs (
  id uuid primary key default gen_random_uuid(),
  passage_id uuid not null references te_passages(id) on delete cascade,
  ord smallint not null,
  body text not null,
  unique(passage_id, ord)
);

create index idx_paragraphs_passage on te_paragraphs(passage_id);

-- ---- te_gist_notes -----------------------------------------------------
create table te_gist_notes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references te_profiles(id) on delete cascade,
  paragraph_id uuid not null references te_paragraphs(id) on delete cascade,
  main_idea_text text,
  supporting_text text,
  main_idea_offset jsonb,
  supporting_offset jsonb,
  updated_at timestamptz default now(),
  unique(user_id, paragraph_id)
);

create index idx_gist_user on te_gist_notes(user_id);

-- ---- te_reconstruction_attempts ----------------------------------------
create table te_reconstruction_attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references te_profiles(id) on delete cascade,
  paragraph_id uuid not null references te_paragraphs(id) on delete cascade,
  gist_note_id uuid references te_gist_notes(id) on delete set null,
  student_text text not null,
  ai_score smallint,
  ai_subscores jsonb,
  ai_feedback jsonb,
  ai_model text,
  created_at timestamptz default now()
);

create index idx_recon_user_created on te_reconstruction_attempts(user_id, created_at desc);

-- ---- te_student_progress (aggregated) ----------------------------------
create table te_student_progress (
  user_id uuid primary key references te_profiles(id) on delete cascade,
  total_paragraphs_attempted int default 0,
  total_gist_notes int default 0,
  total_reconstructions int default 0,
  avg_reconstruction_score numeric,
  last_active_at timestamptz default now()
);

-- =====================================================================
-- RLS Policies
-- =====================================================================

alter table te_organizations enable row level security;
alter table te_profiles enable row level security;
alter table te_passages enable row level security;
alter table te_paragraphs enable row level security;
alter table te_gist_notes enable row level security;
alter table te_reconstruction_attempts enable row level security;
alter table te_student_progress enable row level security;

-- Helper function: get caller's profile (org_id, role) without recursion
create or replace function te_auth_org_id() returns uuid
language sql stable security definer set search_path = public as $$
  select org_id from te_profiles where id = auth.uid()
$$;

create or replace function te_auth_role() returns te_user_role
language sql stable security definer set search_path = public as $$
  select role from te_profiles where id = auth.uid()
$$;

-- te_profiles: self read/update; org instructors+directors can read same-org members
create policy "profiles_self_read" on te_profiles for select
  using (id = auth.uid());
create policy "profiles_self_update" on te_profiles for update
  using (id = auth.uid());
create policy "profiles_self_insert" on te_profiles for insert
  with check (id = auth.uid());
create policy "profiles_org_staff_read" on te_profiles for select
  using (
    org_id is not null
    and org_id = te_auth_org_id()
    and te_auth_role() in ('director', 'instructor')
  );

-- te_organizations: anyone can lookup (needed for signup invite_code flow);
-- directors update their own org
create policy "orgs_public_read" on te_organizations for select
  using (true);
create policy "orgs_director_update" on te_organizations for update
  using (id = te_auth_org_id() and te_auth_role() = 'director');

-- te_passages: public (org_id null) readable by everyone; org te_passages by org members
create policy "passages_public_read" on te_passages for select
  using (org_id is null);
create policy "passages_org_read" on te_passages for select
  using (org_id is not null and org_id = te_auth_org_id());
create policy "passages_org_staff_write" on te_passages for insert
  with check (
    (org_id is null and te_auth_role() = 'director')   -- admin uploads to public
    or (org_id = te_auth_org_id() and te_auth_role() in ('director','instructor'))
  );
create policy "passages_org_staff_update" on te_passages for update
  using (
    (org_id is null and te_auth_role() = 'director')
    or (org_id = te_auth_org_id() and te_auth_role() in ('director','instructor'))
  );

-- te_paragraphs: inherit passage visibility via subquery
create policy "paragraphs_read" on te_paragraphs for select
  using (
    exists (
      select 1 from te_passages p
      where p.id = te_paragraphs.passage_id
        and (p.org_id is null or p.org_id = te_auth_org_id())
    )
  );
create policy "paragraphs_write" on te_paragraphs for insert
  with check (
    exists (
      select 1 from te_passages p
      where p.id = te_paragraphs.passage_id
        and (
          (p.org_id is null and te_auth_role() = 'director')
          or (p.org_id = te_auth_org_id() and te_auth_role() in ('director','instructor'))
        )
    )
  );

-- te_gist_notes: self CRUD; org staff read same-org students' notes
create policy "gist_self_all" on te_gist_notes for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());
create policy "gist_org_staff_read" on te_gist_notes for select
  using (
    te_auth_role() in ('director','instructor')
    and exists (
      select 1 from te_profiles s
      where s.id = te_gist_notes.user_id and s.org_id = te_auth_org_id()
    )
  );

-- te_reconstruction_attempts: self CRUD; org staff read
create policy "recon_self_all" on te_reconstruction_attempts for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());
create policy "recon_org_staff_read" on te_reconstruction_attempts for select
  using (
    te_auth_role() in ('director','instructor')
    and exists (
      select 1 from te_profiles s
      where s.id = te_reconstruction_attempts.user_id and s.org_id = te_auth_org_id()
    )
  );

-- te_student_progress: self read/write; org staff read
create policy "progress_self_all" on te_student_progress for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());
create policy "progress_org_staff_read" on te_student_progress for select
  using (
    te_auth_role() in ('director','instructor')
    and exists (
      select 1 from te_profiles s
      where s.id = te_student_progress.user_id and s.org_id = te_auth_org_id()
    )
  );

-- =====================================================================
-- Trigger: profile auto-create on signup
-- =====================================================================
create or replace function te_handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  -- Only fire for thinking-english signups; ignore signups from
  -- other apps sharing this Supabase project (e.g. pampas-reading).
  if coalesce(new.raw_user_meta_data->>'app', '') <> 'thinking-english' then
    return new;
  end if;

  insert into te_profiles (id, email, display_name, role, org_id)
  values (
    new.id,
    new.email,
    coalesce(new.raw_user_meta_data->>'display_name', split_part(new.email, '@', 1)),
    coalesce((new.raw_user_meta_data->>'role')::te_user_role, 'b2c'),
    nullif(new.raw_user_meta_data->>'org_id','')::uuid
  );
  insert into te_student_progress (user_id) values (new.id);
  return new;
end;
$$;

create trigger on_auth_user_created_te
  after insert on auth.users
  for each row execute function te_handle_new_user();
