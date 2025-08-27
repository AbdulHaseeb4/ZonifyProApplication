import 'package:flutter/material.dart';

class AppTheme {
  // 🌸 Base Colors
  static const Color background = Color(0xFFF7F7FA);   // Light Lavender Gray
  static const Color card = Colors.white;              // White cards/panels

  // 🎨 Accent Colors
  static const Color lavender = Color(0xFF8E7DBE);     // Lavender Purple
  static const Color mint = Color(0xFFA3C9A8);         // Mint Mist
  static const Color peach = Color(0xFFEABF9F);        // Peach Sand

  // 🖌 Neutral Colors
  static const Color textPrimary = Color(0xFF2D2D34);   // Soft Black
  static const Color textSecondary = Color(0xFF6B7280); // Neutral Gray
  static const Color softBeige = Color(0xFFDCCFC0);

  // 🌍 ThemeData
  static ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: background,
    fontFamily: 'Roboto',

    colorScheme: const ColorScheme.light(
      primary: lavender,
      secondary: mint,
      surface: card,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textPrimary, fontSize: 16),
      bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
      titleLarge: TextStyle(
        color: lavender,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),

    // 🌟 Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lavender,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    // ✨ Input Fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      labelStyle: const TextStyle(color: textSecondary),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: lavender,
          width: 2,
        ),
      ),
    ),
  );
}
