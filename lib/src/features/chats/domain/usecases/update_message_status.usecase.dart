import 'package:chat_app/src/core/utils/usecases/usecase.dart';
import 'package:chat_app/src/features/chats/domain/models/message_status.enum.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';

class UpdateMessageStatusParams {
  final String messageId;
  final MessageStatus status;
  final String chatId;

  UpdateMessageStatusParams({
    required this.messageId,
    required this.status,
    required this.chatId,
  });
}

class UpdateMessageStatusUseCase
    implements UseCase<void, UpdateMessageStatusParams> {
  final ChatRepository repository;
  UpdateMessageStatusUseCase({required this.repository});

  @override
  Future<void> call({required UpdateMessageStatusParams params}) async {
    await repository.updateMessageStatus(
      chatId: params.chatId,
      messageId: params.messageId,
      status: params.status,
    );
  }
}
