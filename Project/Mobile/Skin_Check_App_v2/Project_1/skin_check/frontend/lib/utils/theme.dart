import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color primaryBlueLight = Color(0xFF60A5FA);
  static const Color primaryBlueDark = Color(0xFF1D4ED8);

  static const Color secondaryGreen = Color(0xFF10B981);
  static const Color secondaryOrange = Color(0xFFF59E0B);
  static const Color secondaryRed = Color(0xFFEF4444);
  static const Color secondaryPurple = Color(0xFF8B5CF6);

  static const Color backgroundGray = Color(0xFFF9FAFB);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF111827);
  static const Color textGray = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryBlue,
      brightness: Brightness.light,
    ),
    fontFamily: 'Inter',
    scaffoldBackgroundColor: backgroundGray,
    appBarTheme: const AppBarTheme(
      backgroundColor: surfaceWhite,
      foregroundColor: textDark,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    cardTheme: const CardThemeData(  // ✅ diperbaiki
      color: surfaceWhite,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceWhite,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryBlue, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
  );
}
