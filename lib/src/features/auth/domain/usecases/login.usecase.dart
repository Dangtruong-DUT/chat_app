import 'package:chat_app/src/core/utils/usecases/usecase.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repositories.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';

class LoginUseCaseParams {
  final String email;
  final String password;

  LoginUseCaseParams({required this.email, required this.password});
}

class LoginUseCase extends UseCase<void, LoginUseCaseParams> {
  final AuthRepository repository;
  LoginUseCase({required this.repository});

  @override
  Future<User> call({required LoginUseCaseParams params}) async {
    return repository.login(email: params.email, password: params.password);
  }
}
