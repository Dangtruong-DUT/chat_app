import 'package:chat_app/src/features/chats/domain/models/chat.model.dart';
import 'package:chat_app/src/features/chats/domain/models/message.model.dart';

abstract class ChatRepository {
  Chat getConversations();
  Future<Message> sendMessage({
    required String userId,
    required String receiverId,
    required String content,
  });
  Future<void> updateMessageStatus({
    required String messageId,
    required String status,
  });
}
