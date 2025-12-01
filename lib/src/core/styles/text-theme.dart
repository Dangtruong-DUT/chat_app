import 'package:flutter/material.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTheme(ColorScheme scheme) => TextTheme(
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12.5,
      color: scheme.onSurfaceVariant, // text trên surfaceVariant (card, sheet…)
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: scheme.onSurface, // text trên nền chính (scaffold)
    ),
    labelSmall: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12.5,
      color: scheme.primary, // nhấn mạnh, label, button
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: scheme.primary,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: scheme.onSurface,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: scheme.onSurface,
    ),
  );

  static TextTheme darkTheme(ColorScheme scheme) => lightTheme(scheme);
}
