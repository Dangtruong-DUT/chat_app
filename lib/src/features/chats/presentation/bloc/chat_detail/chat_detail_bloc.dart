import 'package:chat_app/src/core/utils/error/base/error.exception.dart';
import 'package:chat_app/src/core/utils/result/result.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat.entity.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat_context.entity.dart';
import 'package:chat_app/src/features/chats/domain/entities/message_status.enum.dart';
import 'package:chat_app/src/features/chats/domain/usecases/create_conversation.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/get_conversation.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/get_user_by_id.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/send_message.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/update_message_status.usecase.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chat_detail/chat_detail_event.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chat_detail/chat_detail_state.dart';
import 'package:chat_app/src/shared/domain/entities/user.entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  final GetConversationUseCase _getConversationUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final UpdateMessageStatusUseCase _updateMessageStatusUseCase;
  final CreateConversationUseCase _createConversationUseCase;
  final GetUserByIdUseCase _getUserByIdUseCase;
  final String _currentUserId;

  ChatDetailBloc({
    required String currentUserId,
    required GetConversationUseCase getConversationUseCase,
    required SendMessageUseCase sendMessageUseCase,
    required UpdateMessageStatusUseCase updateMessageStatusUseCase,
    required CreateConversationUseCase createConversationUseCase,
    required GetUserByIdUseCase getUserByIdUseCase,
  }) : _currentUserId = currentUserId,
       _getConversationUseCase = getConversationUseCase,
       _sendMessageUseCase = sendMessageUseCase,
       _updateMessageStatusUseCase = updateMessageStatusUseCase,
       _createConversationUseCase = createConversationUseCase,
       _getUserByIdUseCase = getUserByIdUseCase,
       super(ChatDetailState.initial) {
    on<ChatDetailStarted>(_onStarted);
    on<ChatDetailMessageSent>(_onMessageSent);
    on<ChatDetailMessagesMarkedRead>(_onMessagesMarkedRead);
  }

  Future<void> _onStarted(
    ChatDetailStarted event,
    Emitter<ChatDetailState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ChatDetailStatus.loading,
        loadError: null,
        partnerStatus: event.peerId != null
            ? ChatDetailPartnerStatus.loading
            : ChatDetailPartnerStatus.idle,
        partnerError: null,
        sendStatus: ChatDetailSendStatus.idle,
      ),
    );

    if (event.chatId == null && event.peerId == null) {
      emit(
        state.copyWith(
          status: ChatDetailStatus.failure,
          loadError: ErrorException(
            message: 'Either chatId or receiverId must be provided',
          ),
        ),
      );
      return;
    }

    final result = await _loadConversation(event);
    result.fold(
      (error) => emit(
        state.copyWith(status: ChatDetailStatus.failure, loadError: error),
      ),
      (chat) async {
        final context = _buildContext(chat, event.peerId);
        emit(state.copyWith(partnerStatus: ChatDetailPartnerStatus.loading));

        final partnerResult = await _loadPartner(context.peerId);

        User? partner;
        ErrorException? partnerError;
        var partnerStatus = ChatDetailPartnerStatus.ready;

        partnerResult.fold((error) {
          partnerError = error;
          partnerStatus = ChatDetailPartnerStatus.failure;
        }, (user) => partner = user);

        emit(
          state.copyWith(
            status: ChatDetailStatus.ready,
            chat: chat,
            context: context,
            partner: partner,
            partnerStatus: partnerStatus,
            partnerError: partnerError,
            loadError: null,
          ),
        );
      },
    );
  }

  Future<void> _onMessageSent(
    ChatDetailMessageSent event,
    Emitter<ChatDetailState> emit,
  ) async {
    final chat = state.chat;
    final context = state.context;
    if (chat == null || context == null) return;

    emit(
      state.copyWith(sendStatus: ChatDetailSendStatus.sending, sendError: null),
    );

    final params = SendMessageParams(
      chatId: context.chatId,
      userId: context.currentUserId,
      receiverId: context.peerId,
      content: event.content,
    );

    final result = await _sendMessageUseCase.call(params);
    result.fold(
      (error) => emit(
        state.copyWith(
          sendStatus: ChatDetailSendStatus.failure,
          sendError: error,
        ),
      ),
      (newMessage) {
        final updatedChat = chat.copyWith(
          messages: [...chat.messages, newMessage],
        );
        emit(
          state.copyWith(
            sendStatus: ChatDetailSendStatus.idle,
            chat: updatedChat,
            sendError: null,
          ),
        );
      },
    );
  }

  Future<void> _onMessagesMarkedRead(
    ChatDetailMessagesMarkedRead event,
    Emitter<ChatDetailState> emit,
  ) async {
    final chat = state.chat;
    final context = state.context;
    if (chat == null || context == null) return;

    final unreadMessages = chat.messages
        .where(
          (msg) =>
              msg.status != MessageStatus.read &&
              msg.receiverId == context.currentUserId,
        )
        .toList();

    if (unreadMessages.isEmpty) return;

    for (final message in unreadMessages) {
      final params = UpdateMessageStatusParams(
        chatId: context.chatId,
        messageId: message.id,
        status: MessageStatus.read,
      );

      final result = await _updateMessageStatusUseCase.call(params);
      final hasFailure = result.fold((_) => true, (_) => false);
      if (hasFailure) return;
    }

    final updatedMessages = chat.messages.map((msg) {
      if (msg.status != MessageStatus.read &&
          msg.receiverId == context.currentUserId) {
        return msg.copyWith(status: MessageStatus.read);
      }
      return msg;
    }).toList();

    emit(state.copyWith(chat: chat.copyWith(messages: updatedMessages)));
  }

  Future<Result<Chat>> _loadConversation(ChatDetailStarted event) {
    if (event.chatId != null) {
      final params = GetConversationUseCaseParams(chatId: event.chatId!);
      return _getConversationUseCase.call(params);
    }

    if (event.peerId == null) {
      return Future.value(
        failure(
          ErrorException(message: 'Receiver id is required to start chat'),
        ),
      );
    }

    final params = CreateConversationUseCaseParams(
      userId: _currentUserId,
      receiverId: event.peerId!,
    );
    return _createConversationUseCase.call(params);
  }

  ChatContext _buildContext(Chat chat, String? fallbackPeerId) {
    final peerId = chat.addedUserIds.firstWhere(
      (id) => id != _currentUserId,
      orElse: () => fallbackPeerId ?? _currentUserId,
    );

    return ChatContext(
      chatId: chat.id,
      currentUserId: _currentUserId,
      peerId: peerId,
    );
  }

  Future<Result<User>> _loadPartner(String userId) {
    final params = GetUserByIdUseCaseParams(userId: userId);
    return _getUserByIdUseCase.call(params);
  }
}
