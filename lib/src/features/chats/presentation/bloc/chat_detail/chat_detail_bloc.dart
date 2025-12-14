import 'package:chat_app/src/core/utils/exception/base/error.exception.dart';
import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/features/chats/domain/models/chat.model.dart';
import 'package:chat_app/src/features/chats/domain/models/message_status.enum.dart';
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
    try {
      if (event.chatId == null && event.receiverId == null) {
        throw ErrorException(
          message: "Either chatId or receiverId must be provided",
        );
      }

      Chat chat;

      if (event.chatId != null) {
        final params = GetConversationUseCaseParams(chatId: event.chatId!);
        chat = await _getConversationUseCase.call(params: params);
      } else {
        final params = CreateConversationUseCaseParams(
          userId: event.userId,
          receiverId: event.receiverId!,
        );
        chat = await _createConversationUseCase.call(params: params);
      }

      emit(ChatDetailLoaded(chat));
    } on ErrorException catch (e) {
      Logger.error('ChatDetailBloc._onLoadConversation: ${e.toString()}');
      emit(ChatDetailLoadFailure(e));
    } catch (e) {
      Logger.error('ChatDetailBloc._onLoadConversation: ${e.toString()}');
      emit(
        ChatDetailLoadFailure(
          ErrorException(message: "Failed to load conversation"),
        ),
      );
    }
  }

  Future<void> _onSendMessage(
    ChatSendMessage event,
    Emitter<ChatDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ChatDetailLoaded) return;

    try {
      emit(ChatDetailSending(currentState.chat));

      final params = SendMessageParams(
        chatId: event.chatId,
        userId: event.userId,
        receiverId: event.receiverId,
        content: event.content,
      );
      final newMessage = await _sendMessageUseCase.call(params: params);

      final updatedMessages = [...currentState.chat.messages, newMessage];
      final updatedChat = currentState.chat.copyWith(messages: updatedMessages);

      emit(ChatDetailLoaded(updatedChat));
    } on ErrorException catch (e) {
      Logger.error('ChatDetailBloc._onSendMessage: ${e.toString()}');
      emit(ChatDetailSendFailure(currentState.chat, e));
    } catch (e) {
      Logger.error('ChatDetailBloc._onSendMessage: ${e.toString()}');
      emit(
        ChatDetailSendFailure(
          currentState.chat,
          ErrorException(message: "Failed to send message"),
        ),
      );
    }
  }

  Future<void> _onUpdateMessageStatus(
    ChatUpdateStatusMessage event,
    Emitter<ChatDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ChatDetailLoaded) return;

    try {
      final unreadMessages = currentState.chat.messages.where(
        (msg) => msg.status != MessageStatus.read,
      );

      for (final message in unreadMessages) {
        final params = UpdateMessageStatusParams(
          chatId: event.chatId,
          messageId: message.id,
          status: MessageStatus.read,
        );
        await _updateMessageStatusUseCase.call(params: params);
      }

      final updatedMessages = currentState.chat.messages.map((msg) {
        if (msg.status != MessageStatus.read) {
          return msg.copyWith(status: MessageStatus.read);
        }
        return msg;
      }).toList();

      final updatedChat = currentState.chat.copyWith(messages: updatedMessages);
      emit(ChatDetailLoaded(updatedChat));
    } on ErrorException catch (e) {
      Logger.error('ChatDetailBloc._onUpdateMessageStatus: ${e.toString()}');
    } catch (e) {
      Logger.error('ChatDetailBloc._onUpdateMessageStatus: ${e.toString()}');
    }
  }
}
