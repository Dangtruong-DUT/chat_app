import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/core/utils/usecases/usecase.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';

class UpdateMessageStatusParams {
  final String messageId;
  final String status;

  UpdateMessageStatusParams({required this.messageId, required this.status});
}

class UpdateMessageStatusUseCase
    implements UseCase<void, UpdateMessageStatusParams> {
  final ChatRepository repository;
  UpdateMessageStatusUseCase({required this.repository});

  @override
  Future<void> call({required UpdateMessageStatusParams params}) async {
    Logger.debug(
      'UpdateMessageStatusUseCase - updating ${params.messageId} to ${params.status}',
    );
    await repository.updateMessageStatus(
      messageId: params.messageId,
      status: params.status,
    );
  }
}
