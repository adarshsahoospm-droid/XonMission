# Niche Hiring — Technical Architecture

Production-grade foundation for a solo founder. Optimized for simplicity, clean structure, and fast iteration.

---

## 1. System Architecture Overview

```
┌─────────────────────┐     ┌─────────────────────┐
│  Candidate App      │     │  Recruiter App      │
│  (Flutter)          │     │  (Next.js)          │
│  Android / iOS      │     │  Web                │
└──────────┬──────────┘     └──────────┬──────────┘
           │                           │
           │     Supabase Client       │
           │     (Auth, DB, Storage)   │
           ▼                           ▼
┌──────────────────────────────────────────────────┐
│              Supabase (Hosted)                    │
│  • PostgreSQL (Database + RLS)                    │
│  • Auth (email, OAuth, magic link)                │
│  • Storage                                        │
│  • Edge Functions (optional, only when needed)   │
└──────────────────────────────────────────────────┘
```

- **Single backend**: Supabase. No separate API server to maintain.
- **Client-first**: Both apps talk to Supabase via official SDKs. Row Level Security (RLS) enforces access.
- **Hosting**: Recruiter app on Netlify; Supabase cloud; Flutter builds to Play Store / App Store.

---

## 2. Folder Structure

### Repository (monorepo)

```
NicheHiring/
├── apps/
│   ├── candidate-app/     # Flutter (Android-first)
│   └── recruiter-app/     # Next.js (App Router + Tailwind)
├── supabase/
│   ├── migrations/        # SQL migrations (versioned)
│   └── config.toml        # Local Supabase config (optional)
├── docs/
│   ├── ARCHITECTURE.md    # This file
│   └── LOCAL_SETUP.md     # Dev environment
├── .env.example           # Root env template (references only)
└── readme.md
```

### Flutter app (`apps/candidate-app/`)

```
candidate-app/
├── lib/
│   ├── main.dart
│   ├── app.dart                 # MaterialApp, theme, routes
│   ├── core/                    # Shared across app
│   │   ├── auth/                # Auth state, session, Supabase client
│   │   ├── config/              # Env, constants
│   │   ├── router/              # GoRouter or Navigator
│   │   └── theme/
│   ├── features/                # Feature-based (add later)
│   │   └── (e.g. profile/, jobs/)
│   └── shared/                  # Reusable widgets, utils
├── test/
├── android/
├── ios/
├── pubspec.yaml
└── .env.example
```

- **Convention**: One feature per folder under `features/`. Each feature can have `data/`, `domain/`, `ui/` if it grows; start flat.

### Next.js app (`apps/recruiter-app/`)

```
recruiter-app/
├── src/
│   ├── app/                     # App Router
│   │   ├── layout.tsx
│   │   ├── page.tsx              # Landing or redirect
│   │   ├── (auth)/               # Auth routes (login, signup, callback)
│   │   ├── (dashboard)/         # Protected recruiter UI
│   │   │   └── layout.tsx       # Auth check, sidebar
│   │   └── api/                 # Route handlers only if needed
│   ├── components/              # Shared UI
│   │   ├── ui/                  # Primitives
│   │   └── layout/
│   ├── lib/                     # Core logic, no UI
│   │   ├── supabase/
│   │   │   ├── client.ts        # Browser client
│   │   │   ├── server.ts        # Server client (RSC)
│   │   │   └── middleware.ts   # Auth refresh
│   │   ├── auth/                # Session, role checks
│   │   └── config.ts            # Env, constants
│   └── types/                   # Shared TS types (DB, auth)
├── public/
├── package.json
├── tailwind.config.ts
├── next.config.js
└── .env.example
```

- **Convention**: Use route groups `(auth)` and `(dashboard)` for layout boundaries. Keep `lib/` for Supabase, auth, and config; add feature folders under `src/` when needed.

### Shared backend conventions

- **No shared code repo**: Avoid a separate “shared” package for now. Duplicate small type definitions or constants if needed; add a shared package only when duplication hurts.
- **Supabase as source of truth**: Table and RLS definitions live in `supabase/migrations/`. Both apps consume the same API; types can be generated with `supabase gen types typescript` (Next.js) and mirrored manually or via script in Flutter if desired.
- **Naming**: Tables and columns in `snake_case`; Supabase returns JSON in snake_case. Use consistent naming in both apps (e.g. `user_id`, `role`).

---

## 3. Supabase Project Structure

### Recommended layout

- **Project**: One Supabase project for dev/staging and one for production (or one project with env-based config for a solo founder).
- **Migrations**: All schema and RLS in `supabase/migrations/` with sequential names:
  - `YYYYMMDDHHMMSS_create_profiles_and_roles.sql`
  - `YYYYMMDDHHMMSS_rls_policies.sql`
  - etc.

### Core tables (foundation only)

- **auth.users**: Managed by Supabase Auth; do not add app columns here.
- **public.profiles**: One row per user; link via `id = auth.uid()`. Stores `role` and minimal shared fields.
- **public.recruiter_profiles** (optional): Extra recruiter-only data; join when `profiles.role = 'recruiter'`.
- **public.candidate_profiles** (optional): Extra candidate-only data; join when `profiles.role = 'candidate'`.

Keep the first migration minimal: `profiles` with `id`, `role`, `email`, `created_at`, `updated_at`. Add recruiter/candidate tables when you add features.

### RLS strategy

- Enable RLS on every app table.
- Default: deny all. Add policies per role/table.
- Use `auth.uid()` in policies; join to `profiles` when you need `role`.
- Prefer one migration per “concept” (e.g. profiles, then RLS for profiles).

---

## 4. Authentication Design

### User types and roles

- **Two roles**: `candidate` and `recruiter`. Stored in `public.profiles.role`.
- **Single auth identity**: Supabase Auth has one user per email; `profiles.role` decides which app and what data they can access.
- **No separate “admin”** for now; add later if needed.

### Role-based access

- **RLS**: Policies check `profiles.role` (via join or helper) and `auth.uid()`.
- **App-level**: 
  - Candidate app: after login, ensure `profiles.role = 'candidate'`; else show “wrong app” and sign out.
  - Recruiter app: ensure `profiles.role = 'recruiter'`; else redirect or show error.
- **Sign-up**: A trigger creates a `profiles` row on first sign-up. Role comes from `raw_user_meta_data.role` if set (e.g. recruiter app calls `signUp({ email, password, options: { data: { role: 'recruiter' } } })`); otherwise default is `candidate`.

### Auth flow — Mobile (Flutter)

1. App start: init Supabase client with anon key and URL.
2. Check existing session: `Supabase.instance.client.auth.currentSession`.
3. If no session: show login/signup (email+password or magic link).
4. After sign-in: fetch `profiles` for `auth.uid()`; if `role != 'candidate'`, sign out and show “Use the recruiter app” (or similar).
5. Persist session: Supabase SDK handles refresh; use secure storage (e.g. flutter_secure_storage) if you customize.
6. Logout: `Supabase.instance.client.auth.signOut()`.

### Auth flow — Web (Next.js)

1. Use `@supabase/ssr` for cookies: create browser client, server client, and middleware that refreshes the session.
2. Middleware: run on protected routes; redirect to login if no session.
3. After login (e.g. callback): fetch profile; if `role != 'recruiter'`, sign out and show error or redirect.
4. Server components: use server Supabase client (cookies) to get session and load data.
5. Logout: sign out via client and redirect.

### Summary

- One Supabase Auth user, one `profiles` row with `role`.
- RLS enforces DB access; each app enforces “correct role” after login.
- No product features in auth—only identity and role.

---

## 5. Environment Configuration Strategy

- **Per app**: Each app has its own `.env` / `.env.local` and `.env.example`.
- **Secrets**: Only Supabase URL and anon key in clients. Use Supabase service role only on server (Next.js API or Edge Functions) and never in Flutter or browser.
- **Root `.env.example`**: List variables with dummy values and point to each app’s `.env.example` for details.
- **Netlify**: Set env vars in Netlify dashboard; same names as `.env.example` (e.g. `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`).
- **Flutter**: Use `flutter_dotenv` or `--dart-define` for build-time env; keep `.env` out of version control and document in `.env.example`.

---

## 6. Local Development Setup

- **Supabase**: Option A — use Supabase Cloud and one project for dev. Option B — `supabase init` and `supabase start` for local Postgres + Auth (see `docs/LOCAL_SETUP.md`).
- **Recruiter app**: `cd apps/recruiter-app && npm i && npm run dev`; use `.env.local` with Supabase URL and anon key.
- **Candidate app**: `cd apps/candidate-app && flutter pub get && flutter run`; use same Supabase project and env.
- **Migrations**: Apply with `supabase db push` (cloud) or `supabase db reset` (local). Create with `supabase migration new <name>`.

See **docs/LOCAL_SETUP.md** for step-by-step commands.

---

## 7. Clean Coding Patterns for Scalability

- **Layers**: Prefer a simple flow: UI → layer (e.g. repo/service) → Supabase. No need for full clean architecture; keep “data” and “UI” clearly separated.
- **Naming**: Consistent across stack: `user_id`, `created_at`, `snake_case` in DB and in type definitions where it matches API.
- **Errors**: Handle Supabase errors in one place (e.g. auth helper or API wrapper); map to user-friendly messages.
- **Types**: Generate TS types from Supabase for Next.js; in Flutter, keep small DTOs in sync with API responses.
- **Feature growth**: Add new features as folders under `features/` (Flutter) or under `src/` (Next.js); one migration per logical change.
- **No microservices**: Stay on Supabase + Netlify + app builds. Revisit only when you hit real limits.

---

## Next Steps

- Implement migrations for `profiles` and RLS.
- Wire auth in both apps (login, role check, logout).
- Add env and local setup; then iterate on features from the next prompt onward.
