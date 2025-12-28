import 'package:chat_app/src/core/theme/theme_mode.dart';
import 'package:chat_app/src/features/setting/data/datasources/theme_local_data_source.dart';
import 'package:chat_app/src/features/setting/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  ThemeRepositoryImpl({required this.localDataSource});

  @override
  Future<AppThemeMode> getThemeMode() async {
    return await localDataSource.getThemeMode() ?? AppThemeMode.system;
  }

  @override
  Future<void> saveThemeMode(AppThemeMode mode) {
    return localDataSource.saveThemeMode(mode);
  }
}
