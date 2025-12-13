import 'package:chat_app/src/features/search/domain/repositories/search_repository.usecase.dart';
import 'package:chat_app/src/features/search/domain/usecases/search_users.usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:chat_app/src/features/search/data/repo_impl/search_repository_impl.dart';

final getIt = GetIt.instance;
Future<void> configureSearchFutureDependencies() async {
  getIt.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl());
  getIt.registerLazySingleton<SearchUserUseCase>(
    () => SearchUserUseCase(repository: getIt<SearchRepository>()),
  );
}
