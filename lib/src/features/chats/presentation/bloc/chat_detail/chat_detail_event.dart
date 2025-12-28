sealed class ChatDetailEvent {
  const ChatDetailEvent();
}

class ChatDetailRequested extends ChatDetailEvent {
  final String? chatId;
  final String currentUserId;
  final String? receiverId;

  const ChatDetailRequested({
    this.chatId,
    required this.currentUserId,
    this.receiverId,
  });
}

class ChatDetailMessageSent extends ChatDetailEvent {
  final String chatId;
  final String currentUserId;
  final String receiverId;
  final String content;

  const ChatDetailMessageSent({
    required this.chatId,
    required this.currentUserId,
    required this.receiverId,
    required this.content,
  });
}

class ChatDetailMarkMessagesRead extends ChatDetailEvent {
  final String chatId;
  final String currentUserId;

  const ChatDetailMarkMessagesRead({
    required this.chatId,
    required this.currentUserId,
  });
}
