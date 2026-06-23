import 'package:flutter/material.dart';

/// KZM App Theme - Material 3 Dark Mode
/// Background: Pure Black (#000000)
/// Accent: Red (#E53935)
class AppTheme {
  AppTheme._();

  static const Color _primaryRed = Color(0xFFE53935);
  static const Color _backgroundBlack = Color(0xFF000000);
  static const Color _surfaceDark = Color(0xFF121212);
  static const Color _surfaceVariant = Color(0xFF1E1E1E);
  static const Color _textPrimary = Color(0xFFFAFAFA);
  static const Color _textSecondary = Color(0xFFB3B3B3);

  static ThemeData get darkTheme {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: _primaryRed,
      brightness: Brightness.dark,
      primary: _primaryRed,
      onPrimary: Colors.white,
      secondary: _primaryRed,
      onSecondary: Colors.white,
      surface: _surfaceDark,
      onSurface: _textPrimary,
      surfaceContainerHighest: _surfaceVariant,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _backgroundBlack,
      appBarTheme: const AppBarTheme(
        backgroundColor: _backgroundBlack,
        foregroundColor: _textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: _textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: _surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _surfaceVariant, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryRed, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: _primaryRed,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _textPrimary,
          side: const BorderSide(color: _surfaceVariant),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: _primaryRed),
      ),
      iconTheme: const IconThemeData(color: _textPrimary),
      dividerTheme: const DividerThemeData(
        color: _surfaceVariant,
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: _surfaceVariant,
        contentTextStyle: const TextStyle(color: _textPrimary),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: _primaryRed,
        linearTrackColor: _surfaceVariant,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: _textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: _textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: _textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: _textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(color: _textPrimary, fontSize: 16),
        bodyMedium: TextStyle(color: _textSecondary, fontSize: 14),
        bodySmall: TextStyle(color: _textSecondary, fontSize: 12),
      ),
    );
  }
}
