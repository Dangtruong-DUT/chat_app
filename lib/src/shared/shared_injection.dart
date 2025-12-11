import 'package:get_it/get_it.dart';
import 'package:chat_app/src/shared/data/repo_impl/auth_repository_impl.dart';
import 'package:chat_app/src/shared/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/shared/domain/usecases/clear_current_user.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/get_current_user.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/save_current_user.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/get_login_history.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/add_login_history.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/delete_login_history.usecase.dart';

final getIt = GetIt.instance;
Future<void> configureSharedDependencies() async {
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
  getIt.registerSingleton<GetLoginHistoryUseCase>(
    GetLoginHistoryUseCase(repository: getIt<AuthRepository>()),
  );
  getIt.registerSingleton<AddLoginHistoryUseCase>(
    AddLoginHistoryUseCase(repository: getIt<AuthRepository>()),
  );
  getIt.registerSingleton<DeleteLoginHistoryUseCase>(
    DeleteLoginHistoryUseCase(repository: getIt<AuthRepository>()),
  );
}
