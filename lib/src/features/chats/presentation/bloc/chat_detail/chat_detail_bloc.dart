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
  final GetConversationUseCase getConversationUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final UpdateMessageStatusUseCase updateMessageStatusUseCase;
  final CreateConversationUseCase createConversationUseCase;

  ChatDetailBloc({
    required this.getConversationUseCase,
    required this.sendMessageUseCase,
    required this.updateMessageStatusUseCase,
    required this.createConversationUseCase,
  }) : super(const ChatDetailInitial()) {
    on<ChatsLoad>(_onLoadConversation);
    on<ChatSendMessage>(_onSendMessage);
    on<ChatUpdateStatusMessage>(_onUpdateMessageStatus);
    on<ChatCreateConversation>(_onCreateConversation);
  }

  Future<void> _onLoadConversation(
    ChatsLoad event,
    Emitter<ChatDetailState> emit,
  ) async {
    emit(const ChatDetailLoading());
    try {
      final params = GetConversationUseCaseParams(chatId: event.chatId);
      final chat = await getConversationUseCase(params: params);
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
      final newMessage = await sendMessageUseCase(params: params);

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
      // Update all unread messages to read status
      final unreadMessages = currentState.chat.messages.where(
        (msg) => msg.status != MessageStatus.read,
      );

      for (final message in unreadMessages) {
        final params = UpdateMessageStatusParams(
          chatId: event.chatId,
          messageId: message.id,
          status: MessageStatus.read,
        );
        await updateMessageStatusUseCase(params: params);
      }

      // Update local state
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

  Future<void> _onCreateConversation(
    ChatCreateConversation event,
    Emitter<ChatDetailState> emit,
  ) async {
    emit(const ChatDetailLoading());
    try {
      final newChat = Chat(
        id: '',
        addedUserIds: [event.userId, event.receiverId],
        messages: [],
      );
      emit(ChatDetailLoaded(newChat));
    } catch (e) {
      Logger.error('ChatDetailBloc._onCreateConversation: ${e.toString()}');
      emit(
        ChatDetailLoadFailure(
          ErrorException(message: "Failed to create conversation"),
        ),
      );
    }
  }
}
