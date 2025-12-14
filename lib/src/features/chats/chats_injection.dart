import 'package:chat_app/src/core/utils/injection_module/base_injection_module.dart';
import 'package:chat_app/src/features/chats/data/repo_impl/chat_repository_impl.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';
import 'package:chat_app/src/features/chats/domain/usecases/create_conversation.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/get_all_conversation.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/get_conversation.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/send_message.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/update_message_status.usecase.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chat_detail/chat_detail_bloc.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chats/chats_bloc.dart';
import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

class ChatsInjectionModule implements BaseInjectionModule {
  @override
  Future<void> register() async {
    await _configureRepositoryDependencies();
    await _configureUseCaseDependencies();
    await _configureBlocDependencies();
  }

  Future<void> _configureRepositoryDependencies() async {
    _getIt.registerSingleton<ChatRepository>(ChatRepositoryImpl());
  }

  Future<void> _configureUseCaseDependencies() async {
    _getIt
      ..registerSingleton<GetAllConversationUseCase>(
        GetAllConversationUseCase(repository: _getIt<ChatRepository>()),
      )
      ..registerSingleton<GetConversationUseCase>(
        GetConversationUseCase(repository: _getIt<ChatRepository>()),
      )
      ..registerSingleton<SendMessageUseCase>(
        SendMessageUseCase(repository: _getIt<ChatRepository>()),
      )
      ..registerSingleton<UpdateMessageStatusUseCase>(
        UpdateMessageStatusUseCase(repository: _getIt<ChatRepository>()),
      )
      ..registerSingleton<CreateConversationUseCase>(
        CreateConversationUseCase(chatRepository: _getIt<ChatRepository>()),
      );
  }

  Future<void> _configureBlocDependencies() async {
    _getIt
      ..registerFactory<ChatsBloc>(
        () => ChatsBloc(
          getAllConversationUseCase: _getIt<GetAllConversationUseCase>(),
        ),
      )
      ..registerFactory<ChatDetailBloc>(
        () => ChatDetailBloc(
          getConversationUseCase: _getIt<GetConversationUseCase>(),
          sendMessageUseCase: _getIt<SendMessageUseCase>(),
          updateMessageStatusUseCase: _getIt<UpdateMessageStatusUseCase>(),
          createConversationUseCase: _getIt<CreateConversationUseCase>(),
        ),
      );
  }
}
