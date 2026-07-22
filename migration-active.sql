-- À coller dans Supabase → SQL Editor → Run (une seule fois).
-- Ajoute l'interrupteur ON/OFF (active) aux habitudes. true par défaut = ON.
alter table habits add column if not exists active boolean not null default true;
