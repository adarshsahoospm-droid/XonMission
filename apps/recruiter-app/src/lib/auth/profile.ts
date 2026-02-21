import { createClient } from '@/lib/supabase/server';

export type AppRole = 'candidate' | 'recruiter';

export interface Profile {
  id: string;
  email: string | null;
  role: AppRole;
  created_at: string | null;
  updated_at: string | null;
}

export async function getCurrentProfile(): Promise<Profile | null> {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return null;

  const { data } = await supabase
    .from('profiles')
    .select('id, email, role, created_at, updated_at')
    .eq('id', user.id)
    .single();

  if (!data) return null;
  return data as Profile;
}
