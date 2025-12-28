import 'package:chat_app/src/features/chats/data/models/chat.model.dart';

abstract class ChatLocalDataSource {
  Future<Map<String, ChatModel>> loadAllChats();
  Future<void> saveAllChats(Map<String, ChatModel> chats);
}
