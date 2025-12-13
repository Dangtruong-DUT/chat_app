import 'package:chat_app/src/core/utils/injection_module/base_injection_module.dart';
import 'package:chat_app/src/features/search/data/repo_impl/search_repository_impl.dart';
import 'package:chat_app/src/features/search/domain/repositories/search_repository.usecase.dart';
import 'package:chat_app/src/features/search/domain/usecases/search_users.usecase.dart';
import 'package:chat_app/src/features/search/presentation/bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class SearchInjectionModule implements BaseInjectionModule {
  @override
  Future<void> register() async {
    await _configureRepositoryDependencies();
    await _configureUseCaseDependencies();
    await _configureBlocDependencies();
  }

  Future<void> _configureRepositoryDependencies() async {
    getIt.registerSingleton<SearchRepository>(SearchRepositoryImpl());
  }

  Future<void> _configureUseCaseDependencies() async {
    getIt.registerSingleton<SearchUserUseCase>(
      SearchUserUseCase(repository: getIt<SearchRepository>()),
    );
  }

  Future<void> _configureBlocDependencies() async {
    getIt.registerFactory<SearchBloc>(
      () => SearchBloc(searchUserUseCase: getIt<SearchUserUseCase>()),
    );
  }
}
