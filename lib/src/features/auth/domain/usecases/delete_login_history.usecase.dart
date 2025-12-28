import 'package:chat_app/src/core/utils/mapper/error.mapper.dart';
import 'package:chat_app/src/core/utils/result/result.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/shared/domain/entities/user.entity.dart';

class DeleteLoginHistoryUseCase extends BaseUseCase<List<User>, String> {
  final AuthRepository _repository;

  DeleteLoginHistoryUseCase({required AuthRepository repository})
    : _repository = repository;

  @override
  Future<Result<List<User>>> call(String params) async {
    try {
      final current = await _repository.getLoginHistory();
      final filtered = current.where((u) => u.id != params).toList();
      await _repository.saveLoginHistory(filtered);
      return success(filtered);
    } catch (error) {
      return failure(
        ErrorMapper.mapToError(
          error,
          fallbackMessage: 'Unable to delete login history item',
        ),
      );
    }
  }
}
