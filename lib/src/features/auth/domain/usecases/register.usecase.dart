import 'package:chat_app/src/core/utils/usecases/usecase.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repositories.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';

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

class RegisterUseCase extends UseCase<void, RegisterUseCaseParams> {
  final AuthRepository repository;
  RegisterUseCase({required this.repository});

  @override
  Future<User> call({required RegisterUseCaseParams params}) async {
    return repository.register(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}
