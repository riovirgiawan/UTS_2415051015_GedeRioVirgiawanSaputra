
import 'package:flutter/material.dart';

class AppTheme {
  // Warna utama aplikasi
  static const Color backgroundColor = Color(0xFF121018);
  static const Color surfaceColor = Color(0xFF211C2B);
  static const Color primaryColor = Color(0xFF9B7EDE);
  static const Color accentColor = Color(0xFFC7B5F5);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color secondaryTextColor = Color(0xFFA9A2B5);

  // Konfigurasi tema gelap
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundColor,

      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: accentColor,
        surface: surfaceColor,
        onPrimary: textColor,
        onSecondary: backgroundColor,
        onSurface: textColor,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: false,
      ),

      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: textColor,
        ),
        bodyMedium: TextStyle(
          color: secondaryTextColor,
        ),
      ),

      iconTheme: const IconThemeData(
        color: accentColor,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 14,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        hintStyle: const TextStyle(
          color: secondaryTextColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: primaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
