import 'package:chat_app/src/core/utils/injection_module/base_injection_module.dart';
import 'package:chat_app/src/features/chats/data/repo_impl/chat_repository_impl.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';
import 'package:chat_app/src/features/chats/domain/usecases/create_conversation.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/get_all_conversation.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/get_conversation.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/send_message.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/update_message_status.usecase.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chatDetail/chat_detail_bloc.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chats/chats_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ChatsInjectionModule implements BaseInjectionModule {
  @override
  Future<void> register() async {
    await _configureRepositoryDependencies();
    await _configureUseCaseDependencies();
    await _configureBlocDependencies();
  }

  Future<void> _configureRepositoryDependencies() async {
    getIt.registerSingleton<ChatRepository>(ChatRepositoryImpl());
  }

  Future<void> _configureUseCaseDependencies() async {
    getIt
      ..registerSingleton<GetAllConversationUseCase>(
        GetAllConversationUseCase(repository: getIt<ChatRepository>()),
      )
      ..registerSingleton<GetConversationUseCase>(
        GetConversationUseCase(repository: getIt<ChatRepository>()),
      )
      ..registerSingleton<SendMessageUseCase>(
        SendMessageUseCase(repository: getIt<ChatRepository>()),
      )
      ..registerSingleton<UpdateMessageStatusUseCase>(
        UpdateMessageStatusUseCase(repository: getIt<ChatRepository>()),
      )
      ..registerSingleton<CreateConversationUseCase>(
        CreateConversationUseCase(chatRepository: getIt<ChatRepository>()),
      );
  }

  Future<void> _configureBlocDependencies() async {
    getIt
      ..registerFactory<ChatsBloc>(
        () => ChatsBloc(
          getAllConversationUseCase: getIt<GetAllConversationUseCase>(),
        ),
      )
      ..registerFactory<ChatDetailBloc>(
        () => ChatDetailBloc(
          getConversationUseCase: getIt<GetConversationUseCase>(),
          sendMessageUseCase: getIt<SendMessageUseCase>(),
          updateMessageStatusUseCase: getIt<UpdateMessageStatusUseCase>(),
          createConversationUseCase: getIt<CreateConversationUseCase>(),
        ),
      );
  }
}
