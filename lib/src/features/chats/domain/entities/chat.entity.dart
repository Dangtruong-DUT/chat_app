import 'package:chat_app/src/features/chats/domain/entities/message.entity.dart';

class Chat {
  final String id;
  final List<String> addedUserIds;
  final List<Message> messages;

  const Chat({
    required this.id,
    required this.addedUserIds,
    required this.messages,
  });

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
