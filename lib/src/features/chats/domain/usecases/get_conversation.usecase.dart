import 'package:chat_app/src/core/utils/usecases/usecase.dart';
import 'package:chat_app/src/features/chats/domain/models/chat.model.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';

class GetConversationUseCaseParams {
  final String? chatId;
  final String userId;
  final String receiverId;

  GetConversationUseCaseParams({
    this.chatId,
    required this.userId,
    required this.receiverId,
  });
}

class GetConversationUseCase
    implements UseCase<Chat, GetConversationUseCaseParams> {
  final ChatRepository repository;
  GetConversationUseCase({required this.repository});

  @override
  Future<Chat> call({required GetConversationUseCaseParams params}) async {
    return repository.getConversations(
      chatId: params.chatId,
      userId: params.userId,
    );
  }
}
