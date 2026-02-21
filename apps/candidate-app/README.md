# Niche Hiring — Candidate App (Flutter)

Android-first; iOS later. Uses Supabase for auth and backend.

## Run the app

From this directory (with [Flutter](https://docs.flutter.dev/get-started/install) installed):

```bash
./run.sh
```

Or manually:

```bash
# First time only: generate android/ and ios/
flutter create . --project-name candidate_app

flutter pub get
flutter run
```

Use an Android device or emulator (or iOS simulator on macOS). Optional: copy `.env.example` to `.env` and set `SUPABASE_URL` and `SUPABASE_ANON_KEY` when you add auth.

## Structure

- `lib/core/` — Auth, config, router, theme.
- `lib/features/` — Feature screens (auth, home, etc.). Add new features here.

See repo root `docs/ARCHITECTURE.md` for system overview.
