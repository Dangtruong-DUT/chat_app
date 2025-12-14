import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

class ChatSummary {
  final String id;
  final User user;
  final String lastMessage;
  final DateTime lastUpdated;

  const ChatSummary({
    required this.id,
    required this.user,
    required this.lastMessage,
    required this.lastUpdated,
  });

  ChatSummary copyWith({
    String? id,
    User? user,
    String? lastMessage,
    DateTime? lastUpdated,
  }) {
    return ChatSummary(
      id: id ?? this.id,
      user: user ?? this.user,
      lastMessage: lastMessage ?? this.lastMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
