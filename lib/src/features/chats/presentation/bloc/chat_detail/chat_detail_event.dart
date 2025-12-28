sealed class ChatDetailEvent {
  const ChatDetailEvent();
}

class ChatDetailStarted extends ChatDetailEvent {
  final String? chatId;
  final String? peerId;

  const ChatDetailStarted({this.chatId, this.peerId});
}

class ChatDetailMessageSent extends ChatDetailEvent {
  final String content;

  const ChatDetailMessageSent(this.content);
}

class ChatDetailMessagesMarkedRead extends ChatDetailEvent {
  const ChatDetailMessagesMarkedRead();
}
