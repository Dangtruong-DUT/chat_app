import 'package:chat_app/src/shared/domain/models/user.model.dart';

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
}
