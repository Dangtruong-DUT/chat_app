import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

class GetLoginHistoryUseCase implements BaseUseCase<List<User>, void> {
  final AuthRepository _repository;

  GetLoginHistoryUseCase({required AuthRepository repository})
    : _repository = repository;

  @override
  Future<List<User>> call({required void params}) async {
    try {
      final users = await _repository.getLoginHistory();
      return users;
    } catch (e) {
      return [];
    }
  }
}
