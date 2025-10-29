import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  // Helper function to convert HEX to Color
  static Color _hexToColor(String hexCode) {
    String formattedHex = hexCode.replaceAll('#', '');
    return Color(int.parse('FF$formattedHex', radix: 16));
  }

  // ------------------ Light Theme Colors ------------------
  static final Color lightPrimaryBackground = _hexToColor('F9F9F9'); // Light Ghost
  static final Color lightSecondaryBackground = _hexToColor('E5F0FF'); // Light Powder Blue
  static final Color lightAccent1 = _hexToColor('9B98E7'); // Soft Amethyst
  static final Color lightAccent2 = _hexToColor('FEA3B4'); // Pastel Rose
  static final Color lightTextPrimary = _hexToColor('1F2233'); // Dark Midnight Blue
  static final Color lightTextSecondary = _hexToColor('2C2E43'); // Dark Slate

  // ------------------ Dark Theme Colors ------------------
  static final Color darkPrimaryBackground = _hexToColor('1F2233'); // Dark Midnight Blue
  static final Color darkSecondaryBackground = _hexToColor('2C2E43'); // Dark Slate
  static final Color darkAccent1 = _hexToColor('9B98E7'); // Soft Amethyst
  static final Color darkAccent2 = _hexToColor('FEA3B4'); // Pastel Rose
  static final Color darkTextPrimary = _hexToColor('F9F9F9'); // Light Ghost
  static final Color darkTextSecondary = _hexToColor('E5F0FF'); // Light Powder Blue

  // ------------------ Light Theme ------------------
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightPrimaryBackground,
    colorScheme: ColorScheme.light(
      surface: lightPrimaryBackground,
      primary: lightAccent1,
      secondary: lightAccent2,
      background: lightSecondaryBackground,
      onSurface: lightTextPrimary,
      onPrimary: lightTextPrimary,
      onSecondary: lightTextSecondary,
    ),

    // ------------------ Input Decorations ------------------
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: lightTextSecondary.withOpacity(0.3),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: lightTextSecondary.withOpacity(0.3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: lightAccent1, // Soft Amethyst on focus
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: lightAccent2, // Pastel Rose on error
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: lightAccent2,
          width: 1.5,
        ),
      ),
      errorStyle: GoogleFonts.nunito(
        color: lightAccent2,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    // ------------------ Text Styles ------------------
    textTheme: TextTheme(
      // Headings (Montserrat)
      headlineLarge: GoogleFonts.montserrat(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: lightTextPrimary,
      ),
      headlineMedium: GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: lightTextPrimary,
      ),
      headlineSmall: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: lightTextPrimary,
      ),

      // Body / descriptions (Nunito)
      bodyLarge: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: lightTextPrimary,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: lightTextSecondary,
      ),
      bodySmall: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: lightTextSecondary,
      ),

      // Labels (for buttons, inputs etc.)
      labelLarge: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: lightTextPrimary,
      ),
      labelMedium: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: lightTextSecondary,
      ),
    ),

    // ------------------ Buttons ------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightAccent1,
        foregroundColor: lightTextPrimary,
        textStyle: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  // ------------------ Dark Theme ------------------
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkPrimaryBackground,
    colorScheme: ColorScheme.dark(
      surface: darkPrimaryBackground,
      primary: darkAccent1,
      secondary: darkAccent2,
      background: darkSecondaryBackground,
      onSurface: darkTextPrimary,
      onPrimary: darkTextPrimary,
      onSecondary: darkTextSecondary,
    ),

    // ------------------ Input Decorations ------------------
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: darkTextSecondary.withOpacity(0.3),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: darkTextSecondary.withOpacity(0.3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: darkAccent1, // Soft Amethyst on focus
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: darkAccent2, // Pastel Rose on error
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: darkAccent2,
          width: 1.5,
        ),
      ),
      errorStyle: GoogleFonts.nunito(
        color: darkAccent2,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    // ------------------ Text Styles ------------------
    textTheme: TextTheme(
      // Headings (Montserrat)
      headlineLarge: GoogleFonts.montserrat(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: darkTextPrimary,
      ),
      headlineMedium: GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: darkTextPrimary,
      ),
      headlineSmall: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: darkTextPrimary,
      ),

      // Body / descriptions (Nunito)
      bodyLarge: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: darkTextPrimary,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: darkTextSecondary,
      ),
      bodySmall: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: darkTextSecondary,
      ),

      // Labels (for buttons, inputs etc.)
      labelLarge: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: darkTextPrimary,
      ),
      labelMedium: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: darkTextSecondary,
      ),
    ),

    // ------------------ Buttons ------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkAccent1,
        foregroundColor: darkTextPrimary,
        textStyle: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
