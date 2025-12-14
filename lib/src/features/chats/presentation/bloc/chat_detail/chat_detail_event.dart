sealed class ChatsEvent {
  const ChatsEvent();
}

class ChatsLoad extends ChatsEvent {
  final String? chatId;
  final String userId;
  final String? receiverId;

  const ChatsLoad({this.chatId, required this.userId, this.receiverId});
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
