import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // 🎓 Primary (Brand) - No changes here
  static const Color primary = Color(0xFF673AB7);
  static const Color primaryVariant = Color(0xFF5E35B1);

  // ✨ Secondary / Neutral - [CHANGED]
  // Changed from accent blue to neutral grey to match the UI style.
  // This is used for inactive icons, subtitles, and secondary info.
  static const Color secondary = Color(0xFF9E9E9E); // Medium Grey
  static const Color secondaryVariant = Color(0xFF757575); // Darker Grey for text

  // 🌿 Support / Success
  static const Color success = Color(0xFF66BB6A);

  // ⚠️ Alert / Error
  static const Color error = Color(0xFFE53935);

  // 🩶 Neutral / Background - No changes here, these are perfect
  static const Color lightBackground = Color(0xFFF7F8FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF1F2F6);

  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1C1C1E);
  static const Color darkSurfaceVariant = Color(0xFF2C2C2E);

  static const Color divider = Color(0xFFE0E0E0);

  // 🖋 Text / Icon Colors
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.white; // For text on grey buttons if needed
  static const Color onBackgroundLight = Color(0xFF1E1E1E);
  static const Color onBackgroundDark = Colors.white;
  static const Color onSurfaceLight = Color(0xFF1E1E1E); // Main text color
  static const Color onSurfaceDark = Colors.white;
  static const Color onError = Colors.white;

  // 💡 Subtle Extras
  static const Color hint = Color(0xFF9E9E9E);
  static const Color focus = Color(0xFFB388FF);
}