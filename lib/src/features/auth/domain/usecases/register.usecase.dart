import 'package:chat_app/src/core/utils/usecases/usecase.dart';
import 'package:chat_app/src/features/auth/domain/dtos/register.dto.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repositories.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';

class RegisterUseCase extends UseCase<void, RegisterBodyDto> {
  final AuthRepository repository;
  RegisterUseCase({required this.repository});

  @override
  Future<User> call({required RegisterBodyDto params}) async {
    return repository.register(params);
  }
}
