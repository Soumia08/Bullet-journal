-- Carnet — schéma Supabase (Postgres) + sécurité par ligne (RLS).
-- À coller dans Supabase → SQL Editor → Run. Chaque compte ne voit que SES données.

create table if not exists habits (
  id        text primary key,
  user_id   uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name      text not null,
  type      text not null default 'binary' check (type in ('binary','quant')),
  unit      text not null default '',
  target    int  not null default 1,
  color     text not null default '#C0295A',
  position  int  not null default 0,
  archived  boolean not null default false,
  updated_at timestamptz not null default now()
);

create table if not exists logs (
  user_id   uuid not null default auth.uid() references auth.users(id) on delete cascade,
  day       date not null,
  habit_id  text not null references habits(id) on delete cascade,
  value     text,
  primary key (user_id, day, habit_id)
);

create table if not exists days (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  day     date not null,
  mood    smallint,
  note    text default '',
  primary key (user_id, day)
);

create table if not exists tasks (
  id       text primary key,
  user_id  uuid not null default auth.uid() references auth.users(id) on delete cascade,
  day      date not null,
  txt      text not null,
  done     boolean not null default false,
  position int not null default 0
);
create index if not exists idx_tasks_day on tasks(user_id, day);

-- Sécurité par ligne : indispensable, sinon la clé anon lirait tout.
alter table habits enable row level security;
alter table logs   enable row level security;
alter table days   enable row level security;
alter table tasks  enable row level security;

create policy "own habits" on habits for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "own logs"   on logs   for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "own days"   on days   for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "own tasks"  on tasks  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Realtime (optionnel) : si tu mets REALTIME:true dans config.js
alter publication supabase_realtime add table habits, logs, days, tasks;
