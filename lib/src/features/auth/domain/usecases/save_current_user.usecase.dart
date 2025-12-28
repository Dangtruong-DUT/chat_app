import 'package:chat_app/src/core/utils/mapper/error.mapper.dart';
import 'package:chat_app/src/core/utils/result/result.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/shared/domain/entities/user.entity.dart';
import 'package:easy_localization/easy_localization.dart';

class SaveCurrentUserUseCase extends BaseUseCase<void, User> {
  final AuthRepository _repository;

  SaveCurrentUserUseCase({required AuthRepository repository})
    : _repository = repository;

  @override
  Future<Result<void>> call(User params) async {
    try {
      await _repository.saveLoginData(params);
      return success(null);
    } catch (error) {
      return failure(
        ErrorMapper.mapToError(
          error,
          fallbackMessage: tr('errors.auth.saveCurrentUser'),
        ),
      );
    }
  }
}
