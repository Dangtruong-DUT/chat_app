import 'package:chat_app/src/core/theme/app_color.dart';
import 'package:chat_app/src/core/theme/text_theme.dart';
import 'package:flutter/material.dart';

final lightColorScheme = AppColorPalette.createColorScheme(
  appLight,
  isDark: false,
);
final darkColorScheme = AppColorPalette.createColorScheme(
  appDark,
  isDark: true,
);

class TAppTheme {
  TAppTheme._();

  static ThemeData _themeFromPalette(AppColorPalette palette, bool isDark) {
    final scheme = AppColorPalette.createColorScheme(palette, isDark: isDark);
    final textTheme = isDark
        ? TTextTheme.darkTheme(scheme)
        : TTextTheme.lightTheme(scheme);

    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      fontFamily: "Poppins",
      colorScheme: scheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: palette.background,
      canvasColor: palette.background,
      cardColor: palette.card,
      dividerTheme: DividerThemeData(color: palette.border, thickness: 1),
      appBarTheme: AppBarTheme(
        backgroundColor: palette.background,
        foregroundColor: palette.foreground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme: IconThemeData(color: palette.foreground),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? palette.card : palette.foreground,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: isDark ? palette.foreground : palette.card,
        ),
        actionTextColor: scheme.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.secondary,
        foregroundColor: scheme.onSecondary,
        elevation: 0,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: palette.muted,
        selectedColor: scheme.primary.withValues(alpha: 0.12),
        disabledColor: palette.border,
        labelStyle: textTheme.labelMedium,
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: scheme.primary,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.input,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: palette.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.error, width: 2),
        ),
      ),
    );
  }

  static final lightTheme = _themeFromPalette(appLight, false);

  static final darkTheme = _themeFromPalette(appDark, true);
}
