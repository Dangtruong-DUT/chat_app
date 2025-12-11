import 'package:chat_app/src/core/utils/exception/base/error.exception.dart';
import 'package:chat_app/src/features/chats/domain/models/chat_summary.model.dart';

sealed class ChatsState {
  const ChatsState();
}

class ChatsInitial extends ChatsState {
  const ChatsInitial();
}

class ChatsLoaded extends ChatsState {
  final List<ChatSummary> chats;
  const ChatsLoaded(this.chats);
}

class ChatsLoadFailure extends ChatsState {
  final ErrorException error;

  const ChatsLoadFailure(this.error);
}

class ChatsLoading extends ChatsState {
  const ChatsLoading();
}
