import 'package:chat_app/src/core/utils/type.dart';
import 'package:chat_app/src/features/chats/domain/entities/message.entity.dart';
import 'package:chat_app/src/features/chats/domain/entities/message_status.enum.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.senderId,
    required super.receiverId,
    required super.content,
    required super.timestamp,
    required super.status,
  });

  static MessageModel fromEntity(Message message) => MessageModel(
    id: message.id,
    senderId: message.senderId,
    receiverId: message.receiverId,
    content: message.content,
    timestamp: message.timestamp,
    status: message.status,
  );

  factory MessageModel.fromJson(Json json) => switch (json) {
    {
      'id': String id,
      'senderId': String senderId,
      'receiverId': String receiverId,
      'content': String content,
      'timestamp': String timestamp,
      'status': String status,
    } =>
      MessageModel(
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
    'receiverId': receiverId,
    'content': content,
    'timestamp': timestamp.toIso8601String(),
    'status': status.name,
  };
}
