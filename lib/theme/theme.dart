import 'package:flutter/material.dart';

// Define Gradient Colors
class AppColors {
  static const Color primaryLight = Color(0xFFA072FF);
  static const Color primaryDark = Color(0xFF5121FF);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, primaryDark],
  );
}

// Define Theme
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryLight,
        primary: AppColors.primaryLight,
        secondary: AppColors.primaryDark,
      ),
      scaffoldBackgroundColor: Colors.white,
    );
  }
}
