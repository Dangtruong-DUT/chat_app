import 'package:chat_app/src/core/utils/mapper/error.mapper.dart';
import 'package:chat_app/src/core/utils/result/result.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat.entity.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';

class GetConversationUseCaseParams {
  final String chatId;

  GetConversationUseCaseParams({required this.chatId});
}

class GetConversationUseCase
    extends BaseUseCase<Chat, GetConversationUseCaseParams> {
  final ChatRepository _repository;
  GetConversationUseCase({required ChatRepository repository})
    : _repository = repository;

  @override
  Future<Result<Chat>> call(GetConversationUseCaseParams params) async {
    try {
      final chat = await _repository.getConversationById(chatId: params.chatId);
      return success(chat);
    } catch (error) {
      return failure(
        ErrorMapper.mapToError(
          error,
          fallbackMessage: 'Unable to load conversation',
        ),
      );
    }
  }
}
