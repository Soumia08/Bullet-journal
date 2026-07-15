// Carnet — service worker "réseau d'abord".
// - App installable (écran d'accueil, plein écran) + fonctionne hors-ligne.
// - En ligne : on prend toujours la version fraîche du réseau (pas de cache périmé).
// - Hors-ligne : on retombe sur la dernière version mise en cache.
// - Supabase (API/auth/realtime) et les polices ne sont jamais interceptés.
const CACHE = 'carnet-v2';
const ASSETS = [
  './', './index.html', './manifest.webmanifest', './supabase.js',
  './icon-192.png', './icon-512.png', './icon-maskable.png'
];

self.addEventListener('install', e => {
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(ASSETS)).then(() => self.skipWaiting()));
});

self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys()
      .then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', e => {
  const req = e.request;
  if (req.method !== 'GET') return;
  const url = new URL(req.url);
  if (url.origin !== location.origin) return;   // Supabase, polices... -> réseau normal
  e.respondWith(
    fetch(req)
      .then(res => { const copy = res.clone(); caches.open(CACHE).then(c => c.put(req, copy)).catch(()=>{}); return res; })
      .catch(() => caches.match(req).then(hit => hit || caches.match('./index.html')))
  );
});
