import 'package:chat_app/src/core/utils/json.type.dart';
import 'package:chat_app/src/features/chats/domain/models/message_status.enum.dart';

class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;
  final MessageStatus status;

  const Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    required this.status,
  });

  factory Message.fromJson(Json json) => switch (json) {
    {
      'id': String id,
      'senderId': String senderId,
      'receiverId': String receiverId,
      'content': String content,
      'timestamp': String timestamp,
      'status': String status,
    } =>
      Message(
        id: id,
        senderId: senderId,
        content: content,
        receiverId: receiverId,
        timestamp: DateTime.parse(timestamp),
        status: MessageStatus.values.firstWhere(
          (e) => e.name == status,
          orElse: () => MessageStatus.sent,
        ),
      ),
    _ => throw FormatException('Invalid Message JSON format'),
  };

  Json toJson() => {
    'id': id,
    'senderId': senderId,
    'content': content,
    'timestamp': timestamp.toIso8601String(),
    'status': status.name,
  };
}
