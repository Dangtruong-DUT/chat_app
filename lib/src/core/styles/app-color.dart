import 'package:flutter/material.dart';

const AppColorPalette appLight = AppColorPalette(
  primary: Color.fromARGB(255, 54, 110, 233),
  primaryForeground: Colors.white,
  secondary: Color(0xFF7C3AED),
  secondaryForeground: Colors.white,
  destructive: Color(0xFFDC2626),
  destructiveForeground: Colors.white,
  muted: Color(0xFFF3F4F6),
  mutedForeground: Color(0xFF6B7280),
  accent: Color(0xFF059669),
  accentForeground: Colors.white,
  border: Color.fromARGB(255, 177, 177, 179),
  input: Color(0xFFF8FAFC),
  ring: Color(0xFFBFDBFE),
  background: Color(0xFFFFFFFF),
  foreground: Color(0xFF111827),
  card: Color(0xFFFFFFFF),
  popover: Color(0xFFFFFFFF),
  tooltip: Color(0xFF111827),
);

const AppColorPalette appDark = AppColorPalette(
  primary: Color.fromARGB(255, 139, 187, 241),
  primaryForeground: Color(0xFF0B1220),
  secondary: Color(0xFFD6BCFA),
  secondaryForeground: Color(0xFF0B1220),
  destructive: Color(0xFFFCA5A5),
  destructiveForeground: Color(0xFF2B0A0A),
  muted: Color(0xFF0B1220),
  mutedForeground: Color(0xFF9CA3AF),
  accent: Color(0xFF6EE7B7),
  accentForeground: Color(0xFF05201C),
  border: Color(0xFF1F2937),
  input: Color(0xFF0B1220),
  ring: Color(0xFF1E40AF),
  background: Color(0xFF071023),
  foreground: Color(0xFFE6EEF6),
  card: Color(0xFF0B1220),
  popover: Color(0xFF0C1320),
  tooltip: Color(0xFFE6EEF6),
);

class AppColorPalette {
  final Color primary;
  final Color primaryForeground;
  final Color secondary;
  final Color secondaryForeground;
  final Color destructive;
  final Color destructiveForeground;
  final Color muted;
  final Color mutedForeground;
  final Color accent;
  final Color accentForeground;
  final Color border;
  final Color input;
  final Color ring;
  final Color background;
  final Color foreground;
  final Color card;
  final Color popover;
  final Color tooltip;

  const AppColorPalette({
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryForeground,
    required this.destructive,
    required this.destructiveForeground,
    required this.muted,
    required this.mutedForeground,
    required this.accent,
    required this.accentForeground,
    required this.border,
    required this.input,
    required this.ring,
    required this.background,
    required this.foreground,
    required this.card,
    required this.popover,
    required this.tooltip,
  });

  static ColorScheme createColorScheme(
    AppColorPalette palette, {
    bool isDark = false,
  }) {
    return ColorScheme(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: palette.primary,
      onPrimary: palette.primaryForeground,
      secondary: palette.secondary,
      onSecondary: palette.secondaryForeground,
      error: palette.destructive,
      onError: palette.destructiveForeground,
      surface: palette.background,
      onSurface: palette.foreground,
      surfaceContainerHighest: palette.card,
      onSurfaceVariant: palette.foreground,
      outline: palette.border,
      tertiary: palette.accent,
      onTertiary: palette.accentForeground,
      shadow: palette.ring,
      scrim: Colors.black54,
    );
  }
}
