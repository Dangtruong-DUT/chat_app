import 'package:chat_app/src/core/utils/mapper/error.mapper.dart';
import 'package:chat_app/src/core/utils/result/result.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/search/domain/repositories/search_repository.dart';
import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

class SearchUserUseCaseParams {
  final String query;
  SearchUserUseCaseParams({required this.query});
}

class SearchUserUseCase
    extends BaseUseCase<List<User>, SearchUserUseCaseParams> {
  final SearchRepository _repository;
  SearchUserUseCase({required SearchRepository repository})
    : _repository = repository;

  @override
  Future<Result<List<User>>> call(SearchUserUseCaseParams params) async {
    try {
      final users = await _repository.searchUsers(query: params.query);
      return success(users);
    } catch (error) {
      return failure(
        ErrorMapper.mapToError(
          error,
          fallbackMessage: 'Unable to search users',
        ),
      );
    }
  }
}
