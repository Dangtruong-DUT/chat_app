import 'package:chat_app/src/features/chats/domain/models/chat.model.dart';
import 'package:chat_app/src/features/chats/domain/models/message.model.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  Chat getConversations() {
    // TODO: implement getConversations
    throw UnimplementedError();
  }

  @override
  Future<Message> sendMessage({
    required String userId,
    required String receiverId,
    required String content,
  }) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }

  @override
  Future<void> updateMessageStatus({
    required String messageId,
    required String status,
  }) {
    // TODO: implement updateMessageStatus
    throw UnimplementedError();
  }
}
