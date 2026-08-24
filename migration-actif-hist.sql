-- À coller dans Supabase → SQL Editor → Run (une seule fois).
-- Historique daté du statut ON/OFF : mettre une habitude OFF ne réécrit plus le passé.
alter table habits add column if not exists active_hist text;
