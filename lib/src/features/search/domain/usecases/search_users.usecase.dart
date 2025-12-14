import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/search/domain/repositories/search_repository.usecase.dart';
import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

class SearchUserUseCaseParams {
  final String query;
  SearchUserUseCaseParams({required this.query});
}

class SearchUserUseCase
    implements BaseUseCase<List<User>, SearchUserUseCaseParams> {
  final SearchRepository _repository;
  SearchUserUseCase({required SearchRepository repository})
    : _repository = repository;

  @override
  Future<List<User>> call({required SearchUserUseCaseParams params}) async {
    return _repository.searchUsers(query: params.query);
  }
}
