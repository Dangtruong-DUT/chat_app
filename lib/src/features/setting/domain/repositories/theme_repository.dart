import 'package:chat_app/src/core/theme/theme_mode.dart';

abstract class ThemeRepository {
  Future<AppThemeMode> getThemeMode();
  Future<void> saveThemeMode(AppThemeMode mode);
}
