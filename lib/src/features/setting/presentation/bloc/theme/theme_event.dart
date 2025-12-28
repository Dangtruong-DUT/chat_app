import 'package:chat_app/src/core/theme/theme_mode.dart';

sealed class ThemeEvent {
  const ThemeEvent();
}

class ThemeModeRequested extends ThemeEvent {
  const ThemeModeRequested();
}

class ThemeModeChanged extends ThemeEvent {
  final AppThemeMode mode;

  const ThemeModeChanged(this.mode);
}
