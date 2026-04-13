import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  static final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.skyBlue,
      primary: AppColors.skyBlue,
      secondary: AppColors.coral,
      tertiary: AppColors.purple,
      surface: AppColors.white,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColors.white,
    cardTheme: const CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
    ),
  );
}
