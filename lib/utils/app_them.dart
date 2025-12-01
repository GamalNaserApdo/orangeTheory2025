import 'package:flutter/material.dart';
import 'package:otfksa2/utils/app_colors.dart';
import 'package:otfksa2/utils/app_styles.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFFF37B2D);
  static const Color _lightBackground = Color(0xFFF9F9F9);
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _darkCard = Color(0xFF2C2C2C);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: _primaryColor,
    scaffoldBackgroundColor: _lightBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      primary: _primaryColor,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      color: Colors.white,
    ),
    textTheme: TextTheme(
      labelLarge: AppStyles.bold16Black,
      labelSmall: AppStyles.medium12Gray,
      labelMedium: AppStyles.medium14Black,
      headlineMedium: AppStyles.medium20Black,
      headlineLarge: AppStyles.medium24Black,
      bodyLarge: AppStyles.medium24Black,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: _primaryColor,
    scaffoldBackgroundColor: _darkBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      primary: _primaryColor,
      brightness: Brightness.dark,
      surface: _darkSurface,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _darkSurface,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade800),
      ),
      color: _darkCard,
    ),
    textTheme: TextTheme(
      labelLarge: AppStyles.bold16White,
      labelMedium: AppStyles.medium14White,
      labelSmall: AppStyles.medium12Gray,
      headlineMedium: AppStyles.medium20White,
      headlineLarge: AppStyles.bold24White,
      bodyLarge: AppStyles.medium24White,
    ),
  );
}
