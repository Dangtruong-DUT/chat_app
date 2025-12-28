import 'package:chat_app/src/core/utils/injection_module/base_injection_module.dart';
import 'package:chat_app/src/features/setting/data/datasources/theme_local_data_source.dart';
import 'package:chat_app/src/features/setting/data/datasources/theme_local_data_source_impl.dart';
import 'package:chat_app/src/features/setting/data/repo_impl/theme_repository_impl.dart';
import 'package:chat_app/src/features/setting/domain/repositories/theme_repository.dart';
import 'package:chat_app/src/features/setting/domain/usecases/get_theme_mode.usecase.dart';
import 'package:chat_app/src/features/setting/domain/usecases/update_theme_mode.usecase.dart';
import 'package:chat_app/src/features/setting/presentation/bloc/theme/theme_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingInjectionModule implements BaseInjectionModule {
  final _getIt = GetIt.instance;

  @override
  Future<void> register() async {
    await _configureDataSourceDependencies();
    await _configureRepositoryDependencies();
    await _configureUseCaseDependencies();
    await _configureBlocDependencies();
  }

  Future<void> _configureDataSourceDependencies() async {
    _getIt.registerLazySingleton<ThemeLocalDataSource>(
      () => ThemeLocalDataSourceImpl(store: _getIt<SharedPreferences>()),
    );
  }

  Future<void> _configureRepositoryDependencies() async {
    _getIt.registerLazySingleton<ThemeRepository>(
      () =>
          ThemeRepositoryImpl(localDataSource: _getIt<ThemeLocalDataSource>()),
    );
  }

  Future<void> _configureUseCaseDependencies() async {
    _getIt
      ..registerLazySingleton<GetThemeModeUseCase>(
        () => GetThemeModeUseCase(repository: _getIt<ThemeRepository>()),
      )
      ..registerLazySingleton<UpdateThemeModeUseCase>(
        () => UpdateThemeModeUseCase(repository: _getIt<ThemeRepository>()),
      );
  }

  Future<void> _configureBlocDependencies() async {
    _getIt.registerFactory<ThemeBloc>(
      () => ThemeBloc(
        getThemeModeUseCase: _getIt<GetThemeModeUseCase>(),
        updateThemeModeUseCase: _getIt<UpdateThemeModeUseCase>(),
      ),
    );
  }
}
