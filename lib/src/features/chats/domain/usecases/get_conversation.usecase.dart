import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/chats/domain/models/chat.model.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';

class GetConversationUseCaseParams {
  final String chatId;

  GetConversationUseCaseParams({required this.chatId});
}

class GetConversationUseCase
    implements BaseUseCase<Chat, GetConversationUseCaseParams> {
  final ChatRepository _repository;
  GetConversationUseCase({required ChatRepository repository})
    : _repository = repository;

  @override
  Future<Chat> call({required GetConversationUseCaseParams params}) async {
    return _repository.getConversationById(chatId: params.chatId);
  }
}
