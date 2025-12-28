import 'package:chat_app/src/core/theme/theme_mode.dart';

abstract class ThemeLocalDataSource {
  Future<AppThemeMode?> getThemeMode();
  Future<void> saveThemeMode(AppThemeMode mode);
}
