import 'package:chat_app/src/core/utils/type.dart';
import 'package:chat_app/src/features/chats/domain/models/message.model.dart';

class Chat {
  final String id;
  final List<String> addedUserIds;
  final List<Message> messages;

  Chat({required this.id, required this.addedUserIds, required this.messages});

  factory Chat.fromJson(Json json) => switch (json) {
    {
      'id': String id,
      'addedUserIds': List<dynamic> addedUserIds,
      'messages': List<dynamic> messagesJson,
    } =>
      Chat(
        id: id,
        addedUserIds: List<String>.from(addedUserIds),
        messages: messagesJson
            .map((msgJson) => Message.fromJson(msgJson as Json))
            .toList(),
      ),
    _ => throw FormatException('Invalid Chat JSON format'),
  };

  Json toJson() => {
    'id': id,
    'addedUserIds': addedUserIds,
    'messages': messages.map((msg) => msg.toJson()).toList(),
  };

  Chat copyWith({
    String? id,
    List<String>? addedUserIds,
    List<Message>? messages,
  }) {
    return Chat(
      id: id ?? this.id,
      addedUserIds: addedUserIds ?? this.addedUserIds,
      messages: messages ?? this.messages,
    );
  }
}
