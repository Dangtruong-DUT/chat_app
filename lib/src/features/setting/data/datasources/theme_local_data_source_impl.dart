import 'package:chat_app/src/core/theme/theme_mode.dart';
import 'package:chat_app/src/core/utils/constants/shared_references.constant.dart';
import 'package:chat_app/src/features/setting/data/datasources/theme_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences store;

  ThemeLocalDataSourceImpl({required this.store});

  @override
  Future<AppThemeMode?> getThemeMode() async {
    final value = store.getString(SharedReferenceConfig.themeModeKey);
    if (value == null) return null;
    return AppThemeModeMapper.fromStorage(value);
  }

  @override
  Future<void> saveThemeMode(AppThemeMode mode) async {
    await store.setString(
      SharedReferenceConfig.themeModeKey,
      mode.storageValue,
    );
  }
}
