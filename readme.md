# Niche Hiring

Full-stack platform: **Candidate mobile app** (Flutter) + **Recruiter web app** (Next.js), backed by **Supabase**.

## Repo structure

| Path | Purpose |
|------|--------|
| `apps/candidate-app/` | Flutter app (Android-first) |
| `apps/recruiter-app/` | Next.js app (App Router + Tailwind), deploy to Netlify |
| `supabase/migrations/` | SQL migrations (profiles, RLS) |
| `docs/` | [Architecture](docs/ARCHITECTURE.md), [local setup](docs/LOCAL_SETUP.md) |

## Quick start

1. **Supabase**: Create a project at [supabase.com](https://supabase.com). Run the SQL in `supabase/migrations/` in the SQL Editor (or use Supabase CLI: `supabase link` then `supabase db push`).
2. **Recruiter app**: `cd apps/recruiter-app`, copy `.env.example` → `.env.local`, set URL and anon key, then `npm i && npm run dev`.
3. **Candidate app**: `cd apps/candidate-app`, copy `.env.example` → `.env`, set same URL and anon key. If needed, run `flutter create . --project-name candidate_app` to add platform folders, then `flutter pub get && flutter run`.

See **docs/LOCAL_SETUP.md** for step-by-step instructions.

## Auth

- One Supabase Auth user per person; **role** (`candidate` | `recruiter`) is stored in `public.profiles`.
- Candidate app: only allows users with `role = 'candidate'`.
- Recruiter app: only allows users with `role = 'recruiter'`.
- New users get a profile via trigger; default role is `candidate`. Set `role` via sign-up metadata (e.g. `raw_user_meta_data.role`) or by updating the row after sign-up.

## Tech stack

- **Backend**: Supabase (Postgres, Auth, Storage)
- **Candidate app**: Flutter (Supabase Flutter SDK)
- **Recruiter app**: Next.js 15 (App Router), Tailwind, Supabase SSR
- **Hosting**: Supabase (backend), Netlify (web), Play Store / App Store (mobile)

Optimized for a solo founder: simple layout, minimal DevOps, room to add features later.
