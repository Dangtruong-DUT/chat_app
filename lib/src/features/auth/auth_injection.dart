import 'package:chat_app/src/core/utils/injection_module/base_injection_module.dart';
import 'package:chat_app/src/features/auth/data/datasources/auth_local_data_source_impl.dart';
import 'package:chat_app/src/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:chat_app/src/features/auth/data/repo_impl/auth_repository_impl.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/features/auth/domain/usecases/add_login_history.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/clear_current_user.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/delete_login_history.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/get_current_user.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/get_login_history.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/login.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/register.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/save_current_user.usecase.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_history/auth_history_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _getIt = GetIt.instance;

class AuthInjectionModule implements BaseInjectionModule {
  @override
  Future<void> register() async {
    await _configureDataSourceDependencies();
    await _configureRepositoryDependencies();
    await _configureUseCaseDependencies();
    await _configureBlocDependencies();
  }

  Future<void> _configureDataSourceDependencies() async {
    _getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(store: _getIt<SharedPreferences>()),
    );
  }

  Future<void> _configureRepositoryDependencies() async {
    _getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(localDataSource: _getIt<AuthLocalDataSource>()),
    );
  }

  Future<void> _configureUseCaseDependencies() async {
    _getIt
      ..registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(repository: _getIt<AuthRepository>()),
      )
      ..registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCase(repository: _getIt<AuthRepository>()),
      )
      ..registerLazySingleton<GetCurrentUserUseCase>(
        () => GetCurrentUserUseCase(repository: _getIt<AuthRepository>()),
      )
      ..registerLazySingleton<ClearCurrentUserUseCase>(
        () => ClearCurrentUserUseCase(repository: _getIt<AuthRepository>()),
      )
      ..registerLazySingleton<SaveCurrentUserUseCase>(
        () => SaveCurrentUserUseCase(repository: _getIt<AuthRepository>()),
      )
      ..registerLazySingleton<GetLoginHistoryUseCase>(
        () => GetLoginHistoryUseCase(repository: _getIt<AuthRepository>()),
      )
      ..registerLazySingleton<AddLoginHistoryUseCase>(
        () => AddLoginHistoryUseCase(repository: _getIt<AuthRepository>()),
      )
      ..registerLazySingleton<DeleteLoginHistoryUseCase>(
        () => DeleteLoginHistoryUseCase(repository: _getIt<AuthRepository>()),
      );
  }

  Future<void> _configureBlocDependencies() async {
    _getIt
      ..registerFactory<LoginBloc>(
        () => LoginBloc(loginUseCase: _getIt<LoginUseCase>()),
      )
      ..registerFactory<RegisterBloc>(
        () => RegisterBloc(registerUseCase: _getIt<RegisterUseCase>()),
      )
      ..registerFactory<AuthHistoryBloc>(
        () => AuthHistoryBloc(
          getLoginHistoryUseCase: _getIt<GetLoginHistoryUseCase>(),
          deleteLoginHistoryUseCase: _getIt<DeleteLoginHistoryUseCase>(),
        ),
      )
      ..registerFactory<AppAuthBloc>(
        () => AppAuthBloc(
          getCurrentUserUseCase: _getIt<GetCurrentUserUseCase>(),
          clearCurrentUserUseCase: _getIt<ClearCurrentUserUseCase>(),
          saveCurrentUserUseCase: _getIt<SaveCurrentUserUseCase>(),
          addLoginHistoryUseCase: _getIt<AddLoginHistoryUseCase>(),
        ),
      );
  }
}
