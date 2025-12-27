import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

class GetCurrentUserUseCase implements BaseUseCase<User?, void> {
  final AuthRepository _repository;

  GetCurrentUserUseCase({required AuthRepository repository})
    : _repository = repository;

  @override
  Future<User?> call({required void params}) async {
    return await _repository.getLoginData();
  }
}
