import 'package:chat_app/src/core/utils/mapper/error.mapper.dart';
import 'package:chat_app/src/core/utils/result/result.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/shared/domain/entities/user.entity.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginUseCaseParams {
  final String email;
  final String password;

  LoginUseCaseParams({required this.email, required this.password});
}

class LoginUseCase extends BaseUseCase<User, LoginUseCaseParams> {
  final AuthRepository _repository;
  LoginUseCase({required AuthRepository repository}) : _repository = repository;

  @override
  Future<Result<User>> call(LoginUseCaseParams params) async {
    try {
      final user = await _repository.login(
        email: params.email,
        password: params.password,
      );
      return success(user);
    } catch (error) {
      return failure(
        ErrorMapper.mapToError(error, fallbackMessage: tr('errors.auth.login')),
      );
    }
  }
}
