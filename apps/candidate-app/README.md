# Niche Hiring — Candidate App (Flutter)

Android-first; iOS later. Uses Supabase for auth and backend.

## Setup

1. Copy `.env.example` to `.env` and set `SUPABASE_URL` and `SUPABASE_ANON_KEY`.
2. If `android/` and `ios/` are missing, run from this directory:
   ```bash
   flutter create . --project-name candidate_app
   ```
3. Run:
   ```bash
   flutter pub get
   flutter run
   ```

## Structure

- `lib/core/` — Auth, config, router, theme.
- `lib/features/` — Feature screens (auth, home, etc.). Add new features here.

See repo root `docs/ARCHITECTURE.md` for system overview.
