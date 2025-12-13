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

final getIt = GetIt.instance;

class SharedInjectionModule implements BaseInjectionModule {
  @override
  Future<void> register() async {
    await _configureRepositoryDependencies();
    await _configureUseCaseDependencies();
    await _configureBlocDependencies();
  }

  Future<void> _configureRepositoryDependencies() async {
    getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  }

  Future<void> _configureUseCaseDependencies() async {
    getIt
      ..registerSingleton<GetCurrentUserUseCase>(
        GetCurrentUserUseCase(repository: getIt<AuthRepository>()),
      )
      ..registerSingleton<ClearCurrentUserUseCase>(
        ClearCurrentUserUseCase(repository: getIt<AuthRepository>()),
      )
      ..registerSingleton<SaveCurrentUserUseCase>(
        SaveCurrentUserUseCase(repository: getIt<AuthRepository>()),
      )
      ..registerSingleton<GetLoginHistoryUseCase>(
        GetLoginHistoryUseCase(repository: getIt<AuthRepository>()),
      )
      ..registerSingleton<AddLoginHistoryUseCase>(
        AddLoginHistoryUseCase(repository: getIt<AuthRepository>()),
      )
      ..registerSingleton<DeleteLoginHistoryUseCase>(
        DeleteLoginHistoryUseCase(repository: getIt<AuthRepository>()),
      );
  }

  Future<void> _configureBlocDependencies() async {
    getIt.registerFactory<AuthBloc>(
      () => AuthBloc(
        getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
        clearCurrentUserUseCase: getIt<ClearCurrentUserUseCase>(),
        saveCurrentUserUseCase: getIt<SaveCurrentUserUseCase>(),
        getLoginHistoryUseCase: getIt<GetLoginHistoryUseCase>(),
        addLoginHistoryUseCase: getIt<AddLoginHistoryUseCase>(),
        deleteLoginHistoryUseCase: getIt<DeleteLoginHistoryUseCase>(),
      ),
    );
  }
}
