import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/core/utils/usecases/usecase.dart';
import 'package:chat_app/src/features/chats/domain/models/message.model.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';

class SendMessageParams {
  final String userId;
  final String receiverId;
  final String content;

  SendMessageParams({
    required this.userId,
    required this.receiverId,
    required this.content,
  });
}

class SendMessageUseCase implements UseCase<Message, SendMessageParams> {
  final ChatRepository repository;
  SendMessageUseCase({required this.repository});

  @override
  Future<Message> call({required SendMessageParams params}) async {
    Logger.debug(
      'SendMessageUseCase - sending message from ${params.userId} to ${params.receiverId}',
    );
    return repository.sendMessage(
      userId: params.userId,
      receiverId: params.receiverId,
      content: params.content,
    );
  }
}
