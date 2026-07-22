-- À coller dans Supabase → SQL Editor → Run (une seule fois).
-- Ajoute les "jours actifs" par habitude (liste CSV des jours, ex "1,2,3,4,5").
-- Par défaut : tous les jours (0=dimanche .. 6=samedi).
alter table habits add column if not exists active_days text not null default '0,1,2,3,4,5,6';
