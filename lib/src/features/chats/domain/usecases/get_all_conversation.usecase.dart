import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/chats/domain/models/chat_summary.model.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';

class GetAllConversationUseCaseParams {
  final String userId;

  GetAllConversationUseCaseParams({required this.userId});
}

class GetAllConversationUseCase
    implements BaseUseCase<List<ChatSummary>, GetAllConversationUseCaseParams> {
  final ChatRepository _repository;
  GetAllConversationUseCase({required ChatRepository repository})
    : _repository = repository;

  @override
  Future<List<ChatSummary>> call({
    required GetAllConversationUseCaseParams params,
  }) async {
    return _repository.getAllConversations(userId: params.userId);
  }
}
