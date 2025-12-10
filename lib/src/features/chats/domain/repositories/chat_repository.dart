import 'package:chat_app/src/features/chats/domain/models/chat.model.dart';
import 'package:chat_app/src/features/chats/domain/models/message.model.dart';
import 'package:chat_app/src/features/chats/domain/models/message_status.enum.dart';

abstract class ChatRepository {
  Future<Chat> getConversations({required String chatId});
  Future<Chat> createConversation({
    required String userId,
    required String receiverId,
  });

  Future<List<Chat>> getAllConversations({required String userId});

  Future<Message> sendMessage({
    required String chatId,
    required String userId,
    required String receiverId,
    required String content,
  });
  Future<void> updateMessageStatus({
    required String chatId,
    required String messageId,
    required MessageStatus status,
  });
}
