// Carnet — config Supabase.
//  1) cp config.example.js config.js
//  2) remplis config.js avec l'URL + la clé "anon public" de ton projet
//     (Supabase → Project Settings → API).
// La clé anon est PUBLIQUE par design : la sécurité vient des règles RLS
// (voir supabase-schema.sql), pas du secret de la clé.
// Sans config.js, l'app tourne en mode local (aucun compte, aucune synchro).
window.CARNET = {
	SUPABASE_URL:'https://aapicpjcqkqxtxbafoye.supabase.co',
	SUPABASE_ANON_KEY:'sb_publishable_u1uJHKkCd1bo7tlDMZvpeg_h86TXwFE',
    REALTIME: false   // true = la tablette se met à jour toute seule quand tu modifies sur le tel
};
