import 'package:chat_app/src/core/utils/mapper/error.mapper.dart';
import 'package:chat_app/src/core/utils/result/result.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:easy_localization/easy_localization.dart';

class ClearCurrentUserUseCase extends BaseUseCase<void, NoParams> {
  final AuthRepository _repository;

  ClearCurrentUserUseCase({required AuthRepository repository})
    : _repository = repository;

  @override
  Future<Result<void>> call(NoParams params) async {
    try {
      await _repository.clearLoginData();
      return success(null);
    } catch (error) {
      return failure(
        ErrorMapper.mapToError(
          error,
          fallbackMessage: tr('errors.auth.clearCurrentUser'),
        ),
      );
    }
  }
}
