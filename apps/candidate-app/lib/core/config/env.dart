import 'package:flutter_dotenv/flutter_dotenv.dart';

/// App config from environment. Use after [dotenv.load].
abstract class Env {
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
}
