import 'package:chat_app/src/core/utils/usecases/usecase.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repositories.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';

class RegisterParams {
  final String email;
  final String name;
  final String password;

  RegisterParams({
    required this.email,
    required this.name,
    required this.password,
  });
}

class RegisterUseCase extends UseCase<void, RegisterParams> {
  final AuthRepository repository;
  RegisterUseCase({required this.repository});

  @override
  Future<User> call({required RegisterParams params}) async {
    return repository.register(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}
