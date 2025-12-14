import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat.entity.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';

class CreateConversationUseCaseParams {
  final String userId;
  final String receiverId;

  CreateConversationUseCaseParams({
    required this.userId,
    required this.receiverId,
  });
}

class CreateConversationUseCase
    extends BaseUseCase<Chat, CreateConversationUseCaseParams> {
  final ChatRepository _chatRepository;

  CreateConversationUseCase({required ChatRepository chatRepository})
    : _chatRepository = chatRepository;

  @override
  Future<Chat> call({required CreateConversationUseCaseParams params}) async {
    return await _chatRepository.createConversation(
      userId: params.userId,
      receiverId: params.receiverId,
    );
  }
}
