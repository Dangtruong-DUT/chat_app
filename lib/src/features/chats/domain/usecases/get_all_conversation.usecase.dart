import 'package:chat_app/src/core/utils/mapper/error.mapper.dart';
import 'package:chat_app/src/core/utils/result/result.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat_summary.entity.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';
import 'package:easy_localization/easy_localization.dart';

class GetAllConversationUseCaseParams {
  final String userId;

  GetAllConversationUseCaseParams({required this.userId});
}

class GetAllConversationUseCase
    extends BaseUseCase<List<ChatSummary>, GetAllConversationUseCaseParams> {
  final ChatRepository _repository;
  GetAllConversationUseCase({required ChatRepository repository})
    : _repository = repository;

  @override
  Future<Result<List<ChatSummary>>> call(
    GetAllConversationUseCaseParams params,
  ) async {
    try {
      final chats = await _repository.getAllConversations(
        userId: params.userId,
      );
      return success(chats);
    } catch (error) {
      return failure(
        ErrorMapper.mapToError(
          error,
          fallbackMessage: tr('errors.chats.loadConversations'),
        ),
      );
    }
  }
}
