import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

class AppTheme {
  // Prevent instantiation
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      primary: AppColors.primary,
      primaryContainer: AppColors.primaryVariant,
      secondary: AppColors.secondary,
      secondaryContainer: AppColors.secondaryVariant, 
      surface: AppColors.surface,
      error: AppColors.error,
      onPrimary: AppColors.onPrimary,
      onSecondary: AppColors.onSecondary,
      onSurface: AppColors.onSurface,
      onError: AppColors.onError,
      brightness: Brightness.light,
    ),
    textTheme: AppTypography.textTheme,
    iconTheme: const IconThemeData(
      size: 24,
      color: AppColors.primary, // default icon color
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.onPrimary, // Text color
        backgroundColor: AppColors.primary, // Button background color
        minimumSize: const Size(120, 48),
        textStyle: AppTypography.textTheme.bodyLarge, 
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}