import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildDarkTheme() {
  const primaryColor = Color(0xFFBB86FC);
  const secondaryColor = Color(0xFF03DAC6);
  const errorColor = Color(0xFFCF6679);

  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      surface: Color(0xFF121212),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Color(0xFF1E1E1E),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: GoogleFonts.raleway(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Color(0xFFBB86FC),
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 16,
        color: Colors.grey[300],
      ),
      bodyMedium: GoogleFonts.oswald(
        fontSize: 18,
        color: Colors.grey[400],
      ),
      bodySmall: GoogleFonts.akatab(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.grey[500],
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: const Color(0xFF1E1E1E),
    ),
  );
}
