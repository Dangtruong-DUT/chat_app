import 'package:flutter/material.dart';

enum AppThemeMode { system, light, dark }

extension AppThemeModeX on AppThemeMode {
  ThemeMode get materialMode {
    switch (this) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  String get storageValue => name;
}

class AppThemeModeMapper {
  const AppThemeModeMapper._();

  static AppThemeMode fromStorage(String? value) {
    if (value == null || value.isEmpty) return AppThemeMode.system;

    return AppThemeMode.values.firstWhere(
      (mode) => mode.storageValue == value,
      orElse: () => AppThemeMode.system,
    );
  }
}

extension ThemeModeMapperX on ThemeMode {
  AppThemeMode toAppThemeMode() {
    switch (this) {
      case ThemeMode.light:
        return AppThemeMode.light;
      case ThemeMode.dark:
        return AppThemeMode.dark;
      case ThemeMode.system:
        return AppThemeMode.system;
    }
  }
}
