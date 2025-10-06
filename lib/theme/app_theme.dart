import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

class AppTheme {
  // Prevent instantiation
  AppTheme._();

  /// Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      primary: AppColors.primary,
      primaryContainer: AppColors.primaryVariant,
      secondary: AppColors.secondary,
      secondaryContainer: AppColors.secondaryVariant,
      surface: AppColors.lightSurface,
      error: AppColors.error,
      onPrimary: AppColors.onPrimary,
      onSecondary: AppColors.onSecondary,
      onSurface: AppColors.onSurfaceLight,
      onError: AppColors.onError,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme: AppTypography.textTheme.apply(
      bodyColor: AppColors.onSurfaceLight,
      displayColor: AppColors.onSurfaceLight,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.onSurfaceLight,
      size: 24,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        minimumSize: const Size(120, 48),
        textStyle: AppTypography.textTheme.bodyLarge,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    dividerColor: AppColors.divider,
  );

  /// Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      primary: AppColors.primary,
      primaryContainer: AppColors.primaryVariant,
      secondary: AppColors.secondary,
      secondaryContainer: AppColors.secondaryVariant,
      surface: AppColors.darkSurface,
      error: AppColors.error,
      onPrimary: AppColors.onPrimary,
      onSecondary: AppColors.onSecondary,
      onSurface: AppColors.onSurfaceDark,
      onError: AppColors.onError,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: AppTypography.textTheme.apply(
      bodyColor: AppColors.onSurfaceDark,
      displayColor: AppColors.onSurfaceDark,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.onSurfaceDark,
      size: 24,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryVariant,
        foregroundColor: AppColors.onPrimary,
        minimumSize: const Size(120, 48),
        textStyle: AppTypography.textTheme.bodyLarge,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    dividerColor: AppColors.divider,
  );
}
