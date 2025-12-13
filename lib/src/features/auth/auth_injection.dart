import 'package:chat_app/src/core/utils/injection_module/base_injection_module.dart';
import 'package:chat_app/src/features/auth/data/repo_impl/auth_repository_impl.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repositories.dart';
import 'package:chat_app/src/features/auth/domain/usecases/login.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/register.usecase.dart';
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
      );
  }

  Future<void> _configureBlocDependencies() async {
    _getIt
      ..registerFactory<LoginBloc>(
        () => LoginBloc(loginUseCase: _getIt<LoginUseCase>()),
      )
      ..registerFactory<RegisterBloc>(
        () => RegisterBloc(registerUseCase: _getIt<RegisterUseCase>()),
      );
  }
}
