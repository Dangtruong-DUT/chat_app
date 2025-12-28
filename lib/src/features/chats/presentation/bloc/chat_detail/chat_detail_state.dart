import 'package:chat_app/src/core/utils/error/base/error.exception.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat.entity.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat_context.entity.dart';
import 'package:chat_app/src/shared/domain/entities/user.entity.dart';
import 'package:equatable/equatable.dart';

enum ChatDetailStatus { initial, loading, ready, failure }

enum ChatDetailSendStatus { idle, sending, failure }

enum ChatDetailPartnerStatus { idle, loading, ready, failure }

class ChatDetailState extends Equatable {
  final ChatDetailStatus status;
  final ChatDetailSendStatus sendStatus;
  final ChatDetailPartnerStatus partnerStatus;
  final Chat? chat;
  final ChatContext? context;
  final User? partner;
  final ErrorException? partnerError;
  final ErrorException? loadError;
  final ErrorException? sendError;

  const ChatDetailState({
    this.status = ChatDetailStatus.initial,
    this.sendStatus = ChatDetailSendStatus.idle,
    this.partnerStatus = ChatDetailPartnerStatus.idle,
    this.chat,
    this.context,
    this.partner,
    this.partnerError,
    this.loadError,
    this.sendError,
  });

  static const initial = ChatDetailState();

  static const _undefined = Object();

  ChatDetailState copyWith({
    ChatDetailStatus? status,
    ChatDetailSendStatus? sendStatus,
    Object? chat = _undefined,
    Object? context = _undefined,
    Object? partner = _undefined,
    ChatDetailPartnerStatus? partnerStatus,
    Object? partnerError = _undefined,
    Object? loadError = _undefined,
    Object? sendError = _undefined,
  }) {
    return ChatDetailState(
      status: status ?? this.status,
      sendStatus: sendStatus ?? this.sendStatus,
      chat: identical(chat, _undefined) ? this.chat : chat as Chat?,
      context: identical(context, _undefined)
          ? this.context
          : context as ChatContext?,
      partner: identical(partner, _undefined) ? this.partner : partner as User?,
      partnerStatus: partnerStatus ?? this.partnerStatus,
      partnerError: identical(partnerError, _undefined)
          ? this.partnerError
          : partnerError as ErrorException?,
      loadError: identical(loadError, _undefined)
          ? this.loadError
          : loadError as ErrorException?,
      sendError: identical(sendError, _undefined)
          ? this.sendError
          : sendError as ErrorException?,
    );
  }

  bool get hasContext => context != null;

  @override
  List<Object?> get props => [
    status,
    sendStatus,
    chat,
    context,
    partner,
    partnerStatus,
    partnerError,
    loadError,
    sendError,
  ];
}
