import 'dart:convert';
import 'package:chat_app/src/core/utils/constants/shared_references.constant.dart';
import 'package:chat_app/src/core/utils/id_generator.dart';
import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/features/chats/domain/models/chat.model.dart';
import 'package:chat_app/src/features/chats/domain/models/message.model.dart';
import 'package:chat_app/src/features/chats/domain/models/message_status.enum.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<Chat> getConversations({required String chatId}) async {
    try {
      final chats = await _loadAllChats();

      if (chats[chatId] != null) {
        return chats[chatId]!;
      }

      throw Exception("Chat not found");
    } catch (e) {
      Logger.error("getConversations error: $e");
      rethrow;
    }
  }

  @override
  Future<Chat> createConversation({
    required String userId,
    required String receiverId,
  }) async {
    try {
      final chats = await _loadAllChats();

      final chatId = IDGenerator.generator();

      final newChat = Chat(
        id: chatId,
        addedUserIds: [userId, receiverId],
        messages: [],
      );

      chats[chatId] = newChat;

      await _saveAllChats(chats);

      return newChat;
    } catch (e) {
      Logger.error("createConversation error: $e");
      rethrow;
    }
  }

  @override
  Future<Message> sendMessage({
    required String chatId,
    required String userId,
    required String receiverId,
    required String content,
  }) async {
    try {
      final chats = await _loadAllChats();

      final chat =
          chats[chatId] ??
          Chat(id: chatId, addedUserIds: [userId, receiverId], messages: []);

      final message = Message(
        id: IDGenerator.generator(),
        senderId: userId,
        receiverId: receiverId,
        content: content,
        timestamp: DateTime.now(),
        status: MessageStatus.sent,
      );

      final updatedChat = chat.copyWith(messages: [...chat.messages, message]);

      chats[chatId] = updatedChat;

      await _saveAllChats(chats);

      return message;
    } catch (e) {
      Logger.error("sendMessage error: $e");
      rethrow;
    }
  }

  @override
  Future<void> updateMessageStatus({
    required String chatId,
    required String messageId,
    required MessageStatus status,
  }) async {
    try {
      final chats = await _loadAllChats();
      if (!chats.containsKey(chatId)) return;

      final chat = chats[chatId]!;

      final updatedMessages = chat.messages.map((m) {
        if (m.id == messageId) {
          return m.copyWith(status: status);
        }
        return m;
      }).toList();

      chats[chatId] = chat.copyWith(messages: updatedMessages);

      await _saveAllChats(chats);
    } catch (e) {
      Logger.error("updateMessageStatus error: $e");
    }
  }

  Future<Map<String, Chat>> _loadAllChats() async {
    final store = await SharedPreferences.getInstance();
    final raw = store.getString(SharedReferenceConfig.chatConversationsKey);

    if (raw == null) return {};

    final map = jsonDecode(raw) as Map<String, dynamic>;

    return map.map(
      (key, value) =>
          MapEntry(key, Chat.fromJson(value as Map<String, dynamic>)),
    );
  }

  Future<void> _saveAllChats(Map<String, Chat> chats) async {
    final store = await SharedPreferences.getInstance();

    final jsonMap = chats.map((key, chat) => MapEntry(key, chat.toJson()));

    await store.setString(
      SharedReferenceConfig.chatConversationsKey,
      jsonEncode(jsonMap),
    );
  }
}
