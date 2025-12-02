import 'package:chat_app/src/core/utils/usecases/usecase.dart';
import 'package:chat_app/src/features/auth/domain/dtos/login.dto.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repositories.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';

class LoginUseCase extends UseCase<void, LoginBodyDto> {
  final AuthRepository repository;
  LoginUseCase({required this.repository});

  @override
  Future<User> call({required LoginBodyDto params}) async {
    return repository.login(params);
  }
}
