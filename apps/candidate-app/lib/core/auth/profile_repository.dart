import 'package:supabase_flutter/supabase_flutter.dart';

import 'session_service.dart';
import 'supabase_provider.dart';

/// Role stored in public.profiles. Must match backend.
enum AppRole { candidate, recruiter }

/// Minimal profile from public.profiles.
class AppProfile {
  const AppProfile({
    required this.id,
    required this.email,
    required this.role,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String email;
  final AppRole role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  static AppProfile fromMap(Map<String, dynamic> map) {
    final roleStr = map['role'] as String?;
    AppRole role = AppRole.candidate;
    if (roleStr == 'recruiter') role = AppRole.recruiter;

    return AppProfile(
      id: map['id'] as String,
      email: (map['email'] as String?) ?? '',
      role: role,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }
}

/// Fetches profile for current user. Returns null if not found or not signed in.
Future<AppProfile?> getCurrentProfile() async {
  final uid = currentUser?.id;
  if (uid == null) return null;

  final res = await supabase
      .from('profiles')
      .select()
      .eq('id', uid)
      .maybeSingle();

  if (res == null) return null;
  return AppProfile.fromMap(res as Map<String, dynamic>);
}

/// Use from session_service: currentUser
User? get currentUser => supabase.auth.currentUser;
