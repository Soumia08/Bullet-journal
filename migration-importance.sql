-- À coller dans Supabase → SQL Editor → Run (une seule fois).
-- Ajoute la colonne "importance" aux habitudes existantes (défaut 1 = 100%).
alter table habits add column if not exists importance smallint not null default 1;
