import { createBrowserClient } from '@supabase/ssr';
import { env } from '@/lib/config';

export function createClient() {
  return createBrowserClient(env.supabaseUrl, env.supabaseAnonKey);
}
