import 'package:chat_app/src/core/utils/type.dart';
import 'package:chat_app/src/features/chats/data/domain/MessageModel.model.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat.entity.dart';

class ChatModel extends Chat {
  const ChatModel({
    required super.id,
    required super.addedUserIds,
    required super.messages,
  });

  static ChatModel fromEntity(Chat chat) => ChatModel(
    id: chat.id,
    addedUserIds: chat.addedUserIds,
    messages: chat.messages,
  );

  factory ChatModel.fromJson(Json json) => switch (json) {
    {
      'id': String id,
      'addedUserIds': List<dynamic> addedUserIds,
      'messages': List<dynamic> messagesJson,
    } =>
      ChatModel(
        id: id,
        addedUserIds: List<String>.from(addedUserIds),
        messages: messagesJson
            .map((e) => MessageModel.fromJson(e as Json))
            .toList(),
      ),
    _ => throw FormatException('Invalid Chat JSON'),
  };

  Json toJson() => {
    'id': id,
    'addedUserIds': addedUserIds,
    'messages': messages.map((e) => (e as MessageModel).toJson()).toList(),
  };
}
