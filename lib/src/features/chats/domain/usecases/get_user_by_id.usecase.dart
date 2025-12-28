import 'package:chat_app/src/core/utils/mapper/error.mapper.dart';
import 'package:chat_app/src/core/utils/result/result.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';
import 'package:chat_app/src/shared/domain/entities/user.entity.dart';

class GetUserByIdUseCaseParams {
  final String userId;

  GetUserByIdUseCaseParams({required this.userId});
}

class GetUserByIdUseCase extends BaseUseCase<User, GetUserByIdUseCaseParams> {
  final ChatRepository _repository;

  GetUserByIdUseCase({required ChatRepository repository})
    : _repository = repository;

  @override
  Future<Result<User>> call(GetUserByIdUseCaseParams params) async {
    try {
      final user = await _repository.getUserById(userId: params.userId);
      return success(user);
    } catch (error) {
      return failure(
        ErrorMapper.mapToError(error, fallbackMessage: 'Unable to load user'),
      );
    }
  }
}
