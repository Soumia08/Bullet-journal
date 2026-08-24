-- À coller dans Supabase → SQL Editor → Run (une seule fois).
-- Historique daté du planning (jours actifs) : un changement ne réécrit plus le passé.
alter table habits add column if not exists days_hist text;
