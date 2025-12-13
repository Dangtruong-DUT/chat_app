sealed class ChatsEvent {
  const ChatsEvent();
}

class ChatsLoad extends ChatsEvent {
  final String chatId;
  const ChatsLoad({required this.chatId});
}

class ChatSendMessage extends ChatsEvent {
  final String chatId;
  final String userId;
  final String receiverId;
  final String content;

  const ChatSendMessage({
    required this.chatId,
    required this.userId,
    required this.receiverId,
    required this.content,
  });
}

class ChatUpdateStatusMessage extends ChatsEvent {
  final String chatId;

  const ChatUpdateStatusMessage({required this.chatId});
}

class ChatCreateConversation extends ChatsEvent {
  final String userId;
  final String receiverId;

  const ChatCreateConversation({
    required this.userId,
    required this.receiverId,
  });
}
