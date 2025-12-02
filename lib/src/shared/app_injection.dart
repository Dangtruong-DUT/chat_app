import 'package:chat_app/src/features/auth/auth_injection.dart';
import 'package:chat_app/src/shared/data/repo_impl/auth_repository_impl.dart';
import 'package:chat_app/src/shared/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/shared/domain/usecases/clear_current_user.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/get_current_user.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/save_current_user.usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
Future<void> configureAppAuthDependencies() async {
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<GetCurrentUserUseCase>(
    GetCurrentUserUseCase(repository: getIt<AuthRepository>()),
  );
  getIt.registerSingleton<ClearCurrentUserUseCase>(
    ClearCurrentUserUseCase(repository: getIt<AuthRepository>()),
  );
  getIt.registerSingleton<SaveCurrentUserUseCase>(
    SaveCurrentUserUseCase(repository: getIt<AuthRepository>()),
  );
}

Future<void> configureAppDependencies() async {
  await Future.wait([
    configureAppAuthDependencies(),
    configureAuthFutureDependencies(),
  ]);
}
