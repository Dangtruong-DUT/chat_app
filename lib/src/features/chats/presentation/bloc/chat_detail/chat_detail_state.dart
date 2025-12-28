import 'package:chat_app/src/core/utils/error/base/error.exception.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat.entity.dart';

sealed class ChatDetailState {
  const ChatDetailState();
}

class ChatDetailInitial extends ChatDetailState {
  const ChatDetailInitial();
}

class ChatDetailLoading extends ChatDetailState {
  const ChatDetailLoading();
}

class ChatDetailLoaded extends ChatDetailState {
  final Chat chat;
  const ChatDetailLoaded(this.chat);
}

class ChatDetailLoadFailure extends ChatDetailState {
  final ErrorException error;
  const ChatDetailLoadFailure(this.error);
}

class ChatDetailSending extends ChatDetailState {
  final Chat chat;
  const ChatDetailSending(this.chat);
}

class ChatDetailSendFailure extends ChatDetailState {
  final Chat chat;
  final ErrorException error;
  const ChatDetailSendFailure(this.chat, this.error);
}
