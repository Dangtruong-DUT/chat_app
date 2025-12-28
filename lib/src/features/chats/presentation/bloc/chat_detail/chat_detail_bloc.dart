import 'package:chat_app/src/core/utils/error/base/error.exception.dart';
import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/core/utils/result/result.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat.entity.dart';
import 'package:chat_app/src/features/chats/domain/entities/message_status.enum.dart';
import 'package:chat_app/src/features/chats/domain/usecases/create_conversation.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/get_conversation.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/send_message.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/update_message_status.usecase.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chat_detail/chat_detail_event.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chat_detail/chat_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailBloc extends Bloc<ChatsEvent, ChatDetailState> {
  final GetConversationUseCase _getConversationUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final UpdateMessageStatusUseCase _updateMessageStatusUseCase;
  final CreateConversationUseCase _createConversationUseCase;

  ChatDetailBloc({
    required GetConversationUseCase getConversationUseCase,
    required SendMessageUseCase sendMessageUseCase,
    required UpdateMessageStatusUseCase updateMessageStatusUseCase,
    required CreateConversationUseCase createConversationUseCase,
  }) : _getConversationUseCase = getConversationUseCase,
       _sendMessageUseCase = sendMessageUseCase,
       _updateMessageStatusUseCase = updateMessageStatusUseCase,
       _createConversationUseCase = createConversationUseCase,
       super(const ChatDetailInitial()) {
    on<ChatsLoad>(_onLoadConversation);
    on<ChatSendMessage>(_onSendMessage);
    on<ChatUpdateStatusMessage>(_onUpdateMessageStatus);
  }

  Future<void> _onLoadConversation(
    ChatsLoad event,
    Emitter<ChatDetailState> emit,
  ) async {
    emit(const ChatDetailLoading());
    if (event.chatId == null && event.receiverId == null) {
      emit(
        ChatDetailLoadFailure(
          ErrorException(
            message: 'Either chatId or receiverId must be provided',
          ),
        ),
      );
      return;
    }

    Future<Result<Chat>> load() {
      if (event.chatId != null) {
        final params = GetConversationUseCaseParams(chatId: event.chatId!);
        return _getConversationUseCase.call(params);
      }

      final params = CreateConversationUseCaseParams(
        userId: event.userId,
        receiverId: event.receiverId!,
      );
      return _createConversationUseCase.call(params);
    }

    final result = await load();
    result.fold((error) {
      Logger.error('ChatDetailBloc._onLoadConversation: ${error.toString()}');
      emit(ChatDetailLoadFailure(error));
    }, (chat) => emit(ChatDetailLoaded(chat)));
  }

  Future<void> _onSendMessage(
    ChatSendMessage event,
    Emitter<ChatDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ChatDetailLoaded) return;

    emit(ChatDetailSending(currentState.chat));

    final params = SendMessageParams(
      chatId: event.chatId,
      userId: event.userId,
      receiverId: event.receiverId,
      content: event.content,
    );

    final result = await _sendMessageUseCase.call(params);
    result.fold(
      (error) {
        Logger.error('ChatDetailBloc._onSendMessage: ${error.toString()}');
        emit(ChatDetailSendFailure(currentState.chat, error));
      },
      (newMessage) {
        final updatedMessages = [...currentState.chat.messages, newMessage];
        final updatedChat = currentState.chat.copyWith(
          messages: updatedMessages,
        );
        emit(ChatDetailLoaded(updatedChat));
      },
    );
  }

  Future<void> _onUpdateMessageStatus(
    ChatUpdateStatusMessage event,
    Emitter<ChatDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ChatDetailLoaded) return;

    final unreadMessages = currentState.chat.messages.where(
      (msg) => msg.status != MessageStatus.read,
    );

    for (final message in unreadMessages) {
      final params = UpdateMessageStatusParams(
        chatId: event.chatId,
        messageId: message.id,
        status: MessageStatus.read,
      );

      final result = await _updateMessageStatusUseCase.call(params);
      final hasFailure = result.fold((error) {
        Logger.error(
          'ChatDetailBloc._onUpdateMessageStatus: ${error.toString()}',
        );
        return true;
      }, (_) => false);

      if (hasFailure) {
        return;
      }
    }

    final updatedMessages = currentState.chat.messages.map((msg) {
      if (msg.status != MessageStatus.read) {
        return msg.copyWith(status: MessageStatus.read);
      }
      return msg;
    }).toList();

    final updatedChat = currentState.chat.copyWith(messages: updatedMessages);
    emit(ChatDetailLoaded(updatedChat));
  }
}
