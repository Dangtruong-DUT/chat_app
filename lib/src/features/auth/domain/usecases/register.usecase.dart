import 'package:chat_app/src/core/utils/result/result.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/core/utils/mapper/error.mapper.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/shared/domain/entities/user.entity.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterUseCaseParams {
  final String email;
  final String name;
  final String password;

  RegisterUseCaseParams({
    required this.email,
    required this.name,
    required this.password,
  });
}

class RegisterUseCase extends BaseUseCase<User, RegisterUseCaseParams> {
  final AuthRepository _repository;
  RegisterUseCase({required AuthRepository repository})
    : _repository = repository;

  @override
  Future<Result<User>> call(RegisterUseCaseParams params) async {
    try {
      final user = await _repository.register(
        email: params.email,
        password: params.password,
        name: params.name,
      );
      return success(user);
    } catch (error) {
      return failure(
        ErrorMapper.mapToError(
          error,
          fallbackMessage: tr('errors.auth.register'),
        ),
      );
    }
  }
}
