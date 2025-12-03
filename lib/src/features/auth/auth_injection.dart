import 'package:chat_app/src/features/auth/domain/usecases/login.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/register.usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:chat_app/src/features/auth/data/repo_impl/auth_repository_impl.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repositories.dart';

final getIt = GetIt.instance;

Future<void> configureAuthFutureDependencies() async {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(repository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(repository: getIt<AuthRepository>()),
  );
}
