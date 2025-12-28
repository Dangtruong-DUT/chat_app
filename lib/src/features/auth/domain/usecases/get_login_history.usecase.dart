import 'package:chat_app/src/core/utils/mapper/error.mapper.dart';
import 'package:chat_app/src/core/utils/result/result.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

class GetLoginHistoryUseCase extends BaseUseCase<List<User>, NoParams> {
  final AuthRepository _repository;

  GetLoginHistoryUseCase({required AuthRepository repository})
    : _repository = repository;

  @override
  Future<Result<List<User>>> call(NoParams params) async {
    try {
      final history = await _repository.getLoginHistory();
      return success(history);
    } catch (error) {
      return failure(
        ErrorMapper.mapToError(
          error,
          fallbackMessage: 'Unable to fetch login history',
        ),
      );
    }
  }
}
