import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/search/domain/repositories/search_repository.usecase.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';

class SearchUserUseCaseParams {
  final String query;
  SearchUserUseCaseParams({required this.query});
}

class SearchUserUseCase
    implements BaseUseCase<List<User>, SearchUserUseCaseParams> {
  final SearchRepository repository;
  SearchUserUseCase({required this.repository});

  @override
  Future<List<User>> call({required SearchUserUseCaseParams params}) async {
    return repository.searchUsers(query: params.query);
  }
}
