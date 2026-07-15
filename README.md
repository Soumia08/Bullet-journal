# Carnet — bullet journal & suivi d'habitudes (édition Supabase)

PWA trilingue (FR / EN / AR, RTL) installable sur tablette et téléphone,
synchronisée via **Supabase** (Postgres managé, gratuit). Front hébergé
gratuitement sur **Cloudflare Pages**. Aucun serveur à administrer.

## Comment ça marche

Une base Supabase unique = source de vérité. La même PWA sur ta tablette et ton
téléphone, connectée au **même compte**, voit les **mêmes données**. Local-first :
marche hors-ligne sur un cache et rejoue les écritures à la reconnexion.

## Fichiers

| Fichier | Versionné ? | Rôle |
|---|---|---|
| `index.html` | oui | L'application. |
| `manifest.webmanifest`, `sw.js`, `icon-*.png` | oui | PWA. |
| `supabase-schema.sql` | oui | Tables + sécurité par ligne (RLS). |
| `config.example.js` | oui | Template (URL + clé anon). |
| `config.js` | **NON (gitignoré)** | Ta config réelle. Créée depuis le template. |

## 1. Créer la base (Supabase)

1. Compte gratuit sur supabase.com → **New project** (note le mot de passe DB).
2. **SQL Editor** → colle tout `supabase-schema.sql` → **Run**.
3. **Authentication → Providers → Email** : activé. Pour un usage perso, tu peux
   désactiver **Confirm email** (Auth → Settings) pour te connecter sans étape mail.
4. **Project Settings → API** : récupère l'**URL** et la clé **anon public**.

## 2. Configurer le front

```bash
cp config.example.js config.js
```
Renseigne `SUPABASE_URL` et `SUPABASE_ANON_KEY`. Mets `REALTIME:true` si tu veux
que la tablette se rafraîchisse toute seule quand tu modifies sur le téléphone.

> La clé anon est **publique par design** : ce sont les règles RLS (dans le schéma)
> qui garantissent que chaque compte ne voit que ses données. Pas besoin de la cacher,
> mais on garde `config.js` gitignoré par propreté.

## 3. Héberger le front (Cloudflare Pages, gratuit)

Option simple, par dépôt Git :
1. Pousse le projet sur un dépôt (privé possible) GitHub/GitLab.
2. Cloudflare dashboard → **Workers & Pages → Create → Pages → Connect to Git**.
3. Sélectionne le dépôt. **Build command** : (vide). **Output directory** : `/`
   (le projet est déjà statique, pas de build).
4. Déploie → tu obtiens une URL `https://ton-projet.pages.dev` en HTTPS.

> `config.js` est gitignoré : soit tu l'ajoutes comme fichier non suivi au déploiement,
> soit — plus simple sur Pages — tu **committes un `config.js`** (la clé anon étant
> publique, c'est acceptable ici) en le retirant du `.gitignore`. À toi de voir.

Alternative sans Git : `npx wrangler pages deploy .` depuis le dossier.

## 4. Installer sur tes appareils

Ouvre l'URL `.pages.dev` sur la tablette puis le téléphone → menu du navigateur →
**Ajouter à l'écran d'accueil**. Connecte-toi avec le **même e-mail/mot de passe**
sur les deux. C'est tout : mêmes données, synchro automatique.

## Bon à savoir

- **Mise en pause** : un projet Supabase gratuit se met en pause après ~7 jours sans
  activité. Un usage quotidien ne la déclenche jamais ; sinon, ~30 s de réveil.
- **Pas de sauvegarde auto** sur le plan gratuit → l'export/import JSON (à ajouter)
  te sert de filet. Dis-le moi si tu le veux.
- **Concurrence** : un seul toi sur 2 appareils → dernière écriture gagne. Cas rare.
- **Test local** : `python3 -m http.server 8000` puis `http://localhost:8000`.
  Sans `config.js`, l'app tourne en **mode local** (aucun compte) pour valider l'UI.

## Idées d'évolution

- Export / import JSON (backup indépendant de Supabase).
- Vue « objectifs hebdo » (ex. 3×/semaine).
- Rappels via notifications PWA.
