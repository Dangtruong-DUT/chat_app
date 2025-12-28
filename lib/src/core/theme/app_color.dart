import 'package:flutter/material.dart';

const AppColorPalette appLight = AppColorPalette(
  primary: Color(0xFF5563F0),
  primaryForeground: Color(0xFFFFFFFF),
  secondary: Color(0xFF2CB5B4),
  secondaryForeground: Color(0xFF062322),
  destructive: Color(0xFFD64545),
  destructiveForeground: Color(0xFFFFFFFF),
  muted: Color(0xFFF3F4FB),
  mutedForeground: Color(0xFF5F6B7A),
  accent: Color(0xFFFFB74D),
  accentForeground: Color(0xFF3E2723),
  border: Color(0xFFD4DBF1),
  input: Color(0xFFF8FAFF),
  ring: Color(0xFFBFC6FF),
  background: Color(0xFFFDFEFF),
  foreground: Color(0xFF101728),
  card: Color(0xFFFFFFFF),
  popover: Color(0xFFFFFFFF),
  tooltip: Color(0xFF101728),
);

const AppColorPalette appDark = AppColorPalette(
  primary: Color(0xFFA8B4FF),
  primaryForeground: Color(0xFF11162A),
  secondary: Color(0xFF53D2CD),
  secondaryForeground: Color(0xFF021F1E),
  destructive: Color(0xFFFF8A80),
  destructiveForeground: Color(0xFF2E0F0F),
  muted: Color(0xFF1A2237),
  mutedForeground: Color(0xFF9FB3D7),
  accent: Color(0xFFFFD37A),
  accentForeground: Color(0xFF2B1700),
  border: Color(0xFF2A3451),
  input: Color(0xFF1C2740),
  ring: Color(0xFF5A62C7),
  background: Color(0xFF0C1527),
  foreground: Color(0xFFE7ECFF),
  card: Color(0xFF141C32),
  popover: Color(0xFF1B2440),
  tooltip: Color(0xFFE7ECFF),
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
      onSurfaceVariant: palette.mutedForeground,
      outline: palette.border,
      tertiary: palette.accent,
      onTertiary: palette.accentForeground,
      shadow: palette.ring,
      scrim: Colors.black.withValues(alpha: isDark ? 0.6 : 0.35),
      surfaceTint: palette.primary,
    );
  }
}
