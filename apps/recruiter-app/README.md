# Niche Hiring — Recruiter App (Next.js)

App Router + Tailwind. Deploy to Netlify. Uses Supabase for auth and backend.

## Setup

1. `.env.local` is created from `.env.example` so the app can run. Update it with your Supabase URL and anon key when you add auth/backend features.
2. Install and run:
   ```bash
   npm install --legacy-peer-deps
   npm run dev
   ```
   (Use `--legacy-peer-deps` if you see a React/Next peer dependency conflict.)
3. Open [http://localhost:3000](http://localhost:3000).

## Structure

- `src/app/` — App Router: `(auth)` for login, `(dashboard)` for protected recruiter UI.
- `src/lib/` — Supabase clients, auth helpers, config.
- `src/components/` — Shared UI and layout.

See repo root `docs/ARCHITECTURE.md` for system overview.
