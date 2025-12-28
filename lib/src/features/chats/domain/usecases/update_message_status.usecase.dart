import 'package:chat_app/src/core/utils/mapper/error.mapper.dart';
import 'package:chat_app/src/core/utils/result/result.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/chats/domain/entities/message_status.enum.dart';
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
    extends BaseUseCase<void, UpdateMessageStatusParams> {
  final ChatRepository _repository;
  UpdateMessageStatusUseCase({required ChatRepository repository})
    : _repository = repository;

  @override
  Future<Result<void>> call(UpdateMessageStatusParams params) async {
    try {
      await _repository.updateMessageStatus(
        chatId: params.chatId,
        messageId: params.messageId,
        status: params.status,
      );
      return success(null);
    } catch (error) {
      return failure(
        ErrorMapper.mapToError(
          error,
          fallbackMessage: 'Unable to update message status',
        ),
      );
    }
  }
}
