import 'package:chat_app/src/features/chats/domain/usecases/get_all_conversation.usecase.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chats/chats_event.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chats/chats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final GetAllConversationUseCase getAllConversationUseCase;

  ChatsBloc({required this.getAllConversationUseCase})
    : super(const ChatsInitial()) {
    on<ChatsLoad>(_onChatsLoadHandler);
  }

  Future<void> _onChatsLoadHandler(
    ChatsLoad event,
    Emitter<ChatsState> emit,
  ) async {
    emit(const ChatsLoading());
    final params = GetAllConversationUseCaseParams(userId: event.userId);
    final result = await getAllConversationUseCase(params);

    result.fold((error) {
      emit(ChatsLoadFailure(error));
    }, (chats) => emit(ChatsLoaded(chats)));
  }
}
