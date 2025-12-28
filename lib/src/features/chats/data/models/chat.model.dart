import 'package:chat_app/src/core/utils/type.dart';
import 'package:chat_app/src/features/chats/data/models/message.model.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat.entity.dart';

class ChatModel extends Chat {
  const ChatModel({
    required super.id,
    required super.addedUserIds,
    required super.messages,
  });

  static ChatModel fromEntity(Chat chat) => ChatModel(
    id: chat.id,
    addedUserIds: List<String>.from(chat.addedUserIds),
    messages: MessageModel.fromEntityList(chat.messages),
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
    'messages': messages
        .map(
          (message) =>
              (message is MessageModel
                      ? message
                      : MessageModel.fromEntity(message))
                  .toJson(),
        )
        .toList(),
  };

  Chat toEntity() => Chat(
    id: id,
    addedUserIds: List<String>.from(addedUserIds),
    messages: messages
        .map(
          (message) => message is MessageModel ? message.toEntity() : message,
        )
        .toList(),
  );

  static Map<String, ChatModel> fromEntityMap(Map<String, Chat> chats) {
    return chats.map((key, chat) => MapEntry(key, ChatModel.fromEntity(chat)));
  }

  static Map<String, Chat> toEntityMap(Map<String, ChatModel> models) {
    return models.map((key, model) => MapEntry(key, model.toEntity()));
  }
}
