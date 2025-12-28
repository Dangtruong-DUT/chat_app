import 'package:chat_app/src/features/chats/domain/entities/message_status.enum.dart';
import 'package:chat_app/src/shared/domain/entities/user.entity.dart';

class ChatSummary {
  final String id;
  final User user;
  final String? lastMessage;
  final DateTime lastUpdated;
  final MessageStatus? lastMessageStatus;
  final bool isLastMessageFromCurrentUser;
  final bool hasUnreadMessages;

  const ChatSummary({
    required this.id,
    required this.user,
    required this.lastMessage,
    required this.lastUpdated,
    required this.lastMessageStatus,
    required this.isLastMessageFromCurrentUser,
    required this.hasUnreadMessages,
  });

  ChatSummary copyWith({
    String? id,
    User? user,
    String? lastMessage,
    DateTime? lastUpdated,
    MessageStatus? lastMessageStatus,
    bool? isLastMessageFromCurrentUser,
    bool? hasUnreadMessages,
  }) {
    return ChatSummary(
      id: id ?? this.id,
      user: user ?? this.user,
      lastMessage: lastMessage ?? this.lastMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      lastMessageStatus: lastMessageStatus ?? this.lastMessageStatus,
      isLastMessageFromCurrentUser:
          isLastMessageFromCurrentUser ?? this.isLastMessageFromCurrentUser,
      hasUnreadMessages: hasUnreadMessages ?? this.hasUnreadMessages,
    );
  }
}
