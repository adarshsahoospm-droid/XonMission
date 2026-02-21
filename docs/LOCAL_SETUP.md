# Local Development Setup

Minimal steps to run the recruiter app and candidate app against Supabase.

---

## Prerequisites

- Node.js 18+
- Flutter SDK (stable)
- Supabase account
- (Optional) Supabase CLI for local dev: `brew install supabase/tap/supabase`

---

## 1. Supabase Project

1. Create a project at [supabase.com](https://supabase.com).
2. In **Settings → API**: copy **Project URL** and **anon public** key.
3. Apply migrations (from repo root):
   - With Supabase CLI linked: `supabase link --project-ref YOUR_REF` then `supabase db push`
   - Or run the SQL in `supabase/migrations/` manually in the SQL Editor.

---

## 2. Recruiter App (Next.js)

```bash
cd apps/recruiter-app
cp .env.example .env.local
# Edit .env.local: set NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_ANON_KEY
npm install
npm run dev
```

Open [http://localhost:3000](http://localhost:3000).

---

## 3. Candidate App (Flutter)

```bash
cd apps/candidate-app
cp .env.example .env
# Edit .env: set SUPABASE_URL and SUPABASE_ANON_KEY (same as above)
flutter pub get
flutter run
```

Use an Android device or emulator (Android-first).

---

## 4. Env Variables Reference

| Variable | Where | Purpose |
|----------|--------|---------|
| `NEXT_PUBLIC_SUPABASE_URL` | recruiter-app | Supabase project URL |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | recruiter-app | Supabase anon key (public) |
| `SUPABASE_URL` | candidate-app | Same URL |
| `SUPABASE_ANON_KEY` | candidate-app | Same anon key |

Never commit real keys. Use `.env.example` as a template only.

---

## 5. Optional: Local Supabase (CLI)

```bash
supabase init   # if not already
supabase start  # starts Postgres + Auth + Studio
supabase status # shows local URLs and keys
```

Use the local URL and anon key in `.env.local` and `.env` for fully offline dev. Run migrations with `supabase db reset`.
