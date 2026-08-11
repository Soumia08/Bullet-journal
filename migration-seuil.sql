-- À coller dans Supabase → SQL Editor → Run (une seule fois).
-- Ajoute le seuil minimum "tenu" aux habitudes quantifiées (NULL = pas de seuil).
alter table habits add column if not exists seuil numeric;
