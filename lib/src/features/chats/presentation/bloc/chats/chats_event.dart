sealed class ChatsEvent {
  const ChatsEvent();
}

class ChatsLoad extends ChatsEvent {
  final String userId;
  const ChatsLoad({required this.userId});
}
