import 'package:chat_app/src/core/utils/injection_module/base_injection_module.dart';
import 'package:chat_app/src/shared/data/repo_impl/auth_repository_impl.dart';
import 'package:chat_app/src/shared/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/shared/domain/usecases/add_login_history.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/clear_current_user.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/delete_login_history.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/get_current_user.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/get_login_history.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/save_current_user.usecase.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

class SharedInjectionModule implements BaseInjectionModule {
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
    _getIt.registerFactory<AuthBloc>(
      () => AuthBloc(
        getCurrentUserUseCase: _getIt<GetCurrentUserUseCase>(),
        clearCurrentUserUseCase: _getIt<ClearCurrentUserUseCase>(),
        saveCurrentUserUseCase: _getIt<SaveCurrentUserUseCase>(),
        getLoginHistoryUseCase: _getIt<GetLoginHistoryUseCase>(),
        addLoginHistoryUseCase: _getIt<AddLoginHistoryUseCase>(),
        deleteLoginHistoryUseCase: _getIt<DeleteLoginHistoryUseCase>(),
      ),
    );
  }
}
