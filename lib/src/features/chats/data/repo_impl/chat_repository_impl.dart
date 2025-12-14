import 'dart:convert';
import 'package:chat_app/src/core/utils/constants/shared_references.constant.dart';
import 'package:chat_app/src/core/utils/id_generator.dart';
import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/features/chats/data/domain/chat.model.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat.entity.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat_summary.entity.dart';
import 'package:chat_app/src/features/chats/domain/entities/message.entity.dart';
import 'package:chat_app/src/features/chats/domain/entities/message_status.enum.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';
import 'package:chat_app/src/features/user/data/models/user.model.dart';
import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

class ChatRepositoryImpl implements ChatRepository {
  Map<String, Chat>? _chatCache;
  Map<String, User>? _userCache;

  @override
  Future<List<ChatSummary>> getAllConversations({
    required String userId,
  }) async {
    try {
      final chats = await _loadAllChats();
      if (chats.isEmpty) return [];

      final users = await _loadAllUsers();

      final summaries = chats.values
          .where((chat) => chat.addedUserIds.contains(userId))
          .map((chat) {
            final partnerId = chat.addedUserIds.firstWhere(
              (id) => id != userId,
              orElse: () => userId,
            );

            final partner = users[partnerId] ?? _fallbackUser(partnerId);
            final lastMessage = chat.messages.isNotEmpty
                ? chat.messages.last.content
                : '';
            final lastUpdated = chat.messages.isNotEmpty
                ? chat.messages.last.timestamp
                : DateTime.fromMillisecondsSinceEpoch(0);

            return ChatSummary(
              id: chat.id,
              user: partner,
              lastMessage: lastMessage,
              lastUpdated: lastUpdated,
            );
          })
          .toList();

      summaries.sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));

      return summaries;
    } catch (e) {
      Logger.error("getAllConversations error: $e");
      rethrow;
    }
  }

  @override
  Future<Chat> getConversationById({required String chatId}) async {
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

      final existingChat = chats.values.firstWhereOrNull(
        (chat) =>
            chat.addedUserIds.contains(userId) &&
            chat.addedUserIds.contains(receiverId),
      );

      if (existingChat != null) {
        return existingChat;
      }

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
      rethrow;
    }
  }

  Future<Map<String, Chat>> _loadAllChats({bool forceRefresh = false}) async {
    if (!forceRefresh && _chatCache != null) {
      return Map<String, Chat>.from(_chatCache!);
    }

    final store = await SharedPreferences.getInstance();
    final raw = store.getString(SharedReferenceConfig.chatConversationsKey);

    if (raw == null) {
      _chatCache = {};
      return {};
    }

    final map = jsonDecode(raw) as Map<String, dynamic>;

    final parsed = map.map(
      (key, value) =>
          MapEntry(key, ChatModel.fromJson(value as Map<String, dynamic>)),
    );

    _chatCache = Map<String, Chat>.from(parsed);

    return Map<String, Chat>.from(_chatCache!);
  }

  Future<void> _saveAllChats(Map<String, Chat> chats) async {
    final store = await SharedPreferences.getInstance();

    final jsonMap = chats.map(
      (key, chat) => MapEntry(key, (chat as ChatModel).toJson()),
    );

    await store.setString(
      SharedReferenceConfig.chatConversationsKey,
      jsonEncode(jsonMap),
    );

    _chatCache = Map<String, Chat>.from(chats);
  }

  Future<Map<String, User>> _loadAllUsers({bool forceRefresh = false}) async {
    if (!forceRefresh && _userCache != null) {
      return Map<String, User>.from(_userCache!);
    }

    try {
      final store = await SharedPreferences.getInstance();
      final raw = store.getString(SharedReferenceConfig.accountListKey);

      if (raw == null) {
        _userCache = {};
        return {};
      }

      final decoded = jsonDecode(raw) as List<dynamic>;
      final users = decoded
          .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
          .toList();

      _userCache = {for (final user in users) user.id: user};

      return Map<String, User>.from(_userCache!);
    } catch (e) {
      Logger.error('Load users error: $e');
      _userCache = {};
      return {};
    }
  }

  User _fallbackUser(String userId) {
    return User(
      id: userId,
      name: 'Unknown User',
      email: 'unknown_$userId@chat.app',
    );
  }
}
