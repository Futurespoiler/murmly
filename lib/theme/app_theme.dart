import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF8A6BBE); // Morado suave
  static const Color secondaryColor = Color(0xFFFF7E9D); // Rosa cálido
  static const Color accentColor = Color(0xFFFFD166); // Amarillo dorado
  static const Color backgroundColor = Color(0xFFF4F1DE); // Beige claro
  static const Color textColor = Color(0xFF6D6875); // Gris cálido

  // Typography
  static const String primaryFont = 'Poppins';
  static const String secondaryFont = 'Nunito';

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        background: backgroundColor,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: primaryFont,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        bodyLarge: TextStyle(
          fontFamily: secondaryFont,
          fontSize: 16,
          color: textColor,
        ),
        bodyMedium: TextStyle(
          fontFamily: secondaryFont,
          fontSize: 14,
          color: textColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}