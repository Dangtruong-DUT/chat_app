import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

class SaveCurrentUserUseCase implements BaseUseCase<void, User> {
  final AuthRepository _repository;

  SaveCurrentUserUseCase({required AuthRepository repository})
    : _repository = repository;

  @override
  Future<void> call({required User params}) async {
    await _repository.saveLoginData(params);
  }
}
