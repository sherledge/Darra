import 'package:flutter/material.dart';

class AppColors {
  static const Color defaultBackground = Color(0xFFEDEDED);
  static const Color secondary = Color(0xFFFFFFFF);
  static const Color button = Color(0xFF00B899);
  static const Color buttonText = Color(0xFFFFFFFF);
  static const Color secondaryButton = Color(0xFF000000);
  static const Color normalText = Color(0xFF000000);
  static const Color secondaryText = Color(0x66000000); // 40% opacity black
}

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'Inter', 
    scaffoldBackgroundColor: AppColors.defaultBackground,
    cardColor: AppColors.secondary,
    primaryColor: AppColors.button,
    textTheme: 
       const TextTheme(
          headlineLarge: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontFamily: 'Inter'),
          bodyMedium: TextStyle(fontFamily: 'Inter'),
          bodySmall: TextStyle(fontFamily: 'Inter'),
          titleLarge: TextStyle(fontFamily: 'Inter'),
          titleMedium: TextStyle(fontFamily: 'Inter'),
          titleSmall: TextStyle(fontFamily: 'Inter'),
          labelLarge: TextStyle(fontFamily: 'Inter'),
          labelMedium: TextStyle(fontFamily: 'Inter'),
          labelSmall: TextStyle(fontFamily: 'Inter'),
        ),
  );
}
