class ChatContext {
  final String chatId;
  final String currentUserId;
  final String peerId;

  const ChatContext({
    required this.chatId,
    required this.currentUserId,
    required this.peerId,
  });

  ChatContext copyWith({
    String? chatId,
    String? currentUserId,
    String? peerId,
  }) {
    return ChatContext(
      chatId: chatId ?? this.chatId,
      currentUserId: currentUserId ?? this.currentUserId,
      peerId: peerId ?? this.peerId,
    );
  }
}
