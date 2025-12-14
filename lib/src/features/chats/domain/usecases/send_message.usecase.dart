import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/chats/domain/entities/message.entity.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';

class SendMessageParams {
  final String chatId;
  final String userId;
  final String receiverId;
  final String content;

  SendMessageParams({
    required this.chatId,
    required this.userId,
    required this.receiverId,
    required this.content,
  });
}

class SendMessageUseCase implements BaseUseCase<Message, SendMessageParams> {
  final ChatRepository _repository;
  SendMessageUseCase({required ChatRepository repository})
    : _repository = repository;

  @override
  Future<Message> call({required SendMessageParams params}) async {
    return _repository.sendMessage(
      chatId: params.chatId,
      userId: params.userId,
      receiverId: params.receiverId,
      content: params.content,
    );
  }
}
