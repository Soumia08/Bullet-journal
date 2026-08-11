-- À coller dans Supabase → SQL Editor → Run (une seule fois).
-- Modèle simple de revue : rodage/acquise par habitude + marqueur de révision.
alter table habits   add column if not exists rodage boolean not null default true;
alter table settings add column if not exists last_revision date;
