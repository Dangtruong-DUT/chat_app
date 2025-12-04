import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/core/utils/usecases/usecase.dart';
import 'package:chat_app/src/features/chats/domain/models/chat.model.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';

class GetMessagesUseCase implements UseCase<Chat, void> {
  final ChatRepository repository;
  GetMessagesUseCase({required this.repository});

  @override
  Future<Chat> call({required void params}) async {
    Logger.debug('GetMessagesUseCase - fetching conversations');
    return Future.value(repository.getConversations());
  }
}
