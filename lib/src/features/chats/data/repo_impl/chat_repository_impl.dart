import 'dart:convert';

import 'package:chat_app/src/core/utils/constants/shared_references.constant.dart';
import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/features/chats/domain/models/chat.model.dart';
import 'package:chat_app/src/features/chats/domain/models/message.model.dart';
import 'package:chat_app/src/features/chats/domain/models/message_status.enum.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  Chat getConversations() {
    try {
      // synchronous API - but SharedPreferences is async. To keep
      // compatibility with the repository interface we return a
      // default empty Chat when prefs are not yet available.
      // Prefer caller to use the usecase which can be async if needed.
      // Try to read stored conversations synchronously via
      // SharedPreferences.getInstance() would be async, so return
      // an empty chat here and consumer can load from prefs separately.
      // However, to provide meaningful data we'll attempt a quick
      // synchronous fallback to an empty chat.
      return Chat(id: '', userId: '', messages: []);
    } catch (e) {
      Logger.error(
        'ChatRepositoryImpl - getConversations error: ${e.toString()}',
      );
      return Chat(id: '', userId: '', messages: []);
    }
  }

  @override
  Future<Message> sendMessage({
    required String userId,
    required String receiverId,
    required String content,
  }) {
    return Future(() async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final String? chatString = prefs.getString(
          SharedReferenceConfig.chatConversationsKey,
        );

        Chat chat;
        if (chatString != null) {
          final Map<String, dynamic> chatJson =
              jsonDecode(chatString) as Map<String, dynamic>;
          chat = Chat.fromJson(chatJson.cast<String, dynamic>());
        } else {
          chat = Chat(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            userId: userId,
            messages: [],
          );
        }

        final message = Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderId: userId,
          receiverId: receiverId,
          content: content,
          timestamp: DateTime.now(),
          status: MessageStatus.sent,
        );

        final updatedMessages = List<Message>.from(chat.messages)..add(message);
        final updatedChat = Chat(
          id: chat.id,
          userId: chat.userId,
          messages: updatedMessages,
        );

        await prefs.setString(
          SharedReferenceConfig.chatConversationsKey,
          jsonEncode(updatedChat.toJson()),
        );

        return message;
      } catch (e) {
        Logger.error('ChatRepositoryImpl - sendMessage error: ${e.toString()}');
        rethrow;
      }
    });
  }

  @override
  Future<void> updateMessageStatus({
    required String messageId,
    required String status,
  }) {
    return Future(() async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final String? chatString = prefs.getString(
          SharedReferenceConfig.chatConversationsKey,
        );
        if (chatString == null) return;

        final Map<String, dynamic> chatJson =
            jsonDecode(chatString) as Map<String, dynamic>;
        final chat = Chat.fromJson(chatJson.cast<String, dynamic>());

        final updatedMessages = chat.messages.map((m) {
          if (m.id == messageId) {
            final newStatus = MessageStatus.values.firstWhere(
              (e) => e.name == status,
              orElse: () => MessageStatus.sent,
            );
            return Message(
              id: m.id,
              senderId: m.senderId,
              receiverId: m.receiverId,
              content: m.content,
              timestamp: m.timestamp,
              status: newStatus,
            );
          }
          return m;
        }).toList();

        final updatedChat = Chat(
          id: chat.id,
          userId: chat.userId,
          messages: updatedMessages,
        );
        await prefs.setString(
          SharedReferenceConfig.chatConversationsKey,
          jsonEncode(updatedChat.toJson()),
        );
      } catch (e) {
        Logger.error(
          'ChatRepositoryImpl - updateMessageStatus error: ${e.toString()}',
        );
      }
    });
  }
}
