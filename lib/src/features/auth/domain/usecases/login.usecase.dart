import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

class LoginUseCaseParams {
  final String email;
  final String password;

  LoginUseCaseParams({required this.email, required this.password});
}

class LoginUseCase extends BaseUseCase<User, LoginUseCaseParams> {
  final AuthRepository _repository;
  LoginUseCase({required AuthRepository repository}) : _repository = repository;

  @override
  Future<User> call({required LoginUseCaseParams params}) async {
    return _repository.login(email: params.email, password: params.password);
  }
}
