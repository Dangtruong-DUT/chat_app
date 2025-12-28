import 'dart:convert';

import 'package:chat_app/src/core/utils/constants/shared_references.constant.dart';
import 'package:chat_app/src/features/chats/data/datasources/chat_local_data_source.dart';
import 'package:chat_app/src/features/chats/data/models/chat.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final SharedPreferences store;

  ChatLocalDataSourceImpl({required this.store});

  @override
  Future<Map<String, ChatModel>> loadAllChats() async {
    final raw = store.getString(SharedReferenceConfig.chatConversationsKey);

    if (raw == null) {
      return {};
    }

    final decoded = jsonDecode(raw);

    return Map<String, ChatModel>.from(
      decoded.map((key, value) {
        final chatModel = ChatModel.fromJson(value);
        return MapEntry(key, chatModel);
      }),
    );
  }

  @override
  Future<void> saveAllChats(Map<String, ChatModel> chats) async {
    final jsonMap = chats.map((key, chat) {
      return MapEntry(key, chat.toJson());
    });

    await store.setString(
      SharedReferenceConfig.chatConversationsKey,
      jsonEncode(jsonMap),
    );
  }
}
