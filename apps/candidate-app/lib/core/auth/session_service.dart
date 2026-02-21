import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_provider.dart';

/// Returns current session or null if not signed in.
Session? get currentSession => supabase.auth.currentSession;

/// Returns current user or null.
User? get currentUser => supabase.auth.currentUser;

/// Stream of auth state changes (signed in / out).
Stream<AuthState> get authStateChanges => supabase.auth.onAuthStateChange;
