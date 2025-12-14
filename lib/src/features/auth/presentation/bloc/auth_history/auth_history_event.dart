sealed class AuthHistoryEvent {
  const AuthHistoryEvent();
}

class AuthHistoryFetchRequested extends AuthHistoryEvent {
  const AuthHistoryFetchRequested();
}

class AuthHistoryDeleteItemRequested extends AuthHistoryEvent {
  final String id;
  const AuthHistoryDeleteItemRequested({required this.id});
}
