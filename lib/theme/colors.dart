import 'package:flutter/material.dart';

class AppColors {
  // Prevent instantiation
  AppColors._(); 

  // Main Palette
  static const Color primary = Color(0xFF673AB7);
  static const Color primaryVariant = Color(0xFF512DA8);
  static const Color secondary = Color(0xFFFFC107);
  static const Color secondaryVariant = Color(0xFFFFA000);
  
  // App-wide Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFD32F2F);

  // Text/Icon Colors
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.black;
  static const Color onBackground = Colors.black;
  static const Color onSurface = Colors.black;
  static const Color onError = Colors.white;
}