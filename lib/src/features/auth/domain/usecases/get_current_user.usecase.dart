import 'package:chat_app/src/core/utils/mapper/error.mapper.dart';
import 'package:chat_app/src/core/utils/result/result.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

class GetCurrentUserUseCase extends BaseUseCase<User?, NoParams> {
  final AuthRepository _repository;

  GetCurrentUserUseCase({required AuthRepository repository})
    : _repository = repository;

  @override
  Future<Result<User?>> call(NoParams params) async {
    try {
      final user = await _repository.getLoginData();
      throw "Lỗi ở đây nè";
      return success(user);
    } catch (error) {
      return failure(
        ErrorMapper.mapToError(
          error,
          fallbackMessage: 'Unable to fetch current user',
        ),
      );
    }
  }
}
