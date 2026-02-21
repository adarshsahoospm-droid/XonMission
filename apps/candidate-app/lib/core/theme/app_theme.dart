import 'package:flutter/material.dart';

abstract class AppTheme {
  static const Color primaryPurple = Color(0xFF7C3AED);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryPurple, brightness: Brightness.light),
      );
}
