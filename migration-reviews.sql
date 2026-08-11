-- À coller dans Supabase → SQL Editor → Run (une seule fois).
-- Revue hebdomadaire : périodes de plan, revues par semaine, réglages.

create table if not exists periods (
  id         text primary key,
  user_id    uuid not null default auth.uid() references auth.users on delete cascade,
  start      date not null,
  habit_ids  text default '',
  created_at timestamptz not null default now()
);
alter table periods enable row level security;
drop policy if exists periods_all on periods;
create policy periods_all on periods for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create table if not exists reviews (
  user_id    uuid not null default auth.uid() references auth.users on delete cascade,
  week_start date not null,
  period_id  text,
  items      text default '{}',
  created_at timestamptz not null default now(),
  primary key (user_id, week_start)
);
alter table reviews enable row level security;
drop policy if exists reviews_all on reviews;
create policy reviews_all on reviews for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create table if not exists settings (
  user_id    uuid primary key default auth.uid() references auth.users on delete cascade,
  workdays   text default '1,2,3',
  triggers   text default ''
);
alter table settings enable row level security;
drop policy if exists settings_all on settings;
create policy settings_all on settings for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
