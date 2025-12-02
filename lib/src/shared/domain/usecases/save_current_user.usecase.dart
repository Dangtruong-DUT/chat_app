import 'package:chat_app/src/core/utils/usecases/usecase.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';
import 'package:chat_app/src/shared/domain/repositories/auth_repository.dart';

class SaveCurrentUserUseCase implements UseCase<void, User> {
  final AuthRepository repository;

  SaveCurrentUserUseCase({required this.repository});

  @override
  Future<void> call({required User params}) async {
    await repository.saveLoginData(params);
  }
}
