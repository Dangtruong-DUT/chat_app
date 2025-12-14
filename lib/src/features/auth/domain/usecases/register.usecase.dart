import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repositories.dart';
import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

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

class RegisterUseCase extends BaseUseCase<void, RegisterUseCaseParams> {
  final AuthRepository _repository;
  RegisterUseCase({required AuthRepository repository})
    : _repository = repository;

  @override
  Future<User> call({required RegisterUseCaseParams params}) async {
    return _repository.register(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}
