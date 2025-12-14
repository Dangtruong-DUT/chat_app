import 'package:chat_app/src/core/utils/injection_module/base_injection_module.dart';
import 'package:chat_app/src/features/auth/data/repo_impl/auth_repository_impl.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repositories.dart';
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
import 'package:chat_app/src/features/auth/presentation/bloc/login/login-bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/register/register-bloc.dart';
import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

class AuthInjectionModule implements BaseInjectionModule {
  @override
  Future<void> register() async {
    await _configureRepositoryDependencies();
    await _configureUseCaseDependencies();
    await _configureBlocDependencies();
  }

  Future<void> _configureRepositoryDependencies() async {
    _getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  }

  Future<void> _configureUseCaseDependencies() async {
    _getIt
      ..registerSingleton<LoginUseCase>(
        LoginUseCase(repository: _getIt<AuthRepository>()),
      )
      ..registerSingleton<RegisterUseCase>(
        RegisterUseCase(repository: _getIt<AuthRepository>()),
      )
      ..registerSingleton<GetCurrentUserUseCase>(
        GetCurrentUserUseCase(repository: _getIt<AuthRepository>()),
      )
      ..registerSingleton<ClearCurrentUserUseCase>(
        ClearCurrentUserUseCase(repository: _getIt<AuthRepository>()),
      )
      ..registerSingleton<SaveCurrentUserUseCase>(
        SaveCurrentUserUseCase(repository: _getIt<AuthRepository>()),
      )
      ..registerSingleton<GetLoginHistoryUseCase>(
        GetLoginHistoryUseCase(repository: _getIt<AuthRepository>()),
      )
      ..registerSingleton<AddLoginHistoryUseCase>(
        AddLoginHistoryUseCase(repository: _getIt<AuthRepository>()),
      )
      ..registerSingleton<DeleteLoginHistoryUseCase>(
        DeleteLoginHistoryUseCase(repository: _getIt<AuthRepository>()),
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
        ),
      );
  }
}
