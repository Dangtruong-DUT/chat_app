import 'package:chat_app/src/core/utils/json.type.dart';
import 'package:chat_app/src/shared/domain/models/message.model.dart';

class Chat {
  final String id;
  final String userId;
  final List<Message> messages;
  Chat({required this.id, required this.userId, required this.messages});

  factory Chat.fromJson(Json json) => switch (json) {
    {
      'id': String id,
      'userId': String userId,
      'messages': List<dynamic> messagesJson,
    } =>
      Chat(
        id: id,
        userId: userId,
        messages: messagesJson
            .map((msgJson) => Message.fromJson(msgJson as Json))
            .toList(),
      ),
    _ => throw FormatException('Invalid Chat JSON format'),
  };

  Json toJson() => {
    'id': id,
    'userId': userId,
    'messages': messages.map((msg) => msg.toJson()).toList(),
  };
}
