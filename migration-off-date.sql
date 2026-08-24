-- À coller dans Supabase → SQL Editor → Run (une seule fois).
-- Date d'arrêt éditable par habitude : active avant cette date, retirée à partir de cette date.
alter table habits add column if not exists off_date date;
