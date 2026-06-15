import 'package:flutter/material.dart';

class AppTheme {
  static const Color dcsaNavy =
      Color(0xFF0B2A5B);

  static const Color dcsaLight =
      Color(0xFFF5F7FA);

  static ThemeData lightTheme =
      ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor:
        dcsaLight,

    colorScheme: ColorScheme.fromSeed(
      seedColor: dcsaNavy,
      brightness: Brightness.light,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: dcsaNavy,
      centerTitle: true,
      elevation: 0,
    ),

    cardTheme: CardThemeData(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16),
      ),
    ),

    elevatedButtonTheme:
        ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: dcsaNavy,
        foregroundColor: Colors.white,
        minimumSize:
            const Size.fromHeight(52),
        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(
            14,
          ),
        ),
      ),
    ),

    inputDecorationTheme:
        InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),
    ),
  );
}