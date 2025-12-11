import 'package:chat_app/src/features/chats/data/repo_impl/chat_repository_impl.dart';
import 'package:chat_app/src/features/chats/domain/repositories/chat_repository.dart';
import 'package:chat_app/src/features/chats/domain/usecases/get_all_conversation.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/get_conversation.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/send_message.usecase.dart';
import 'package:chat_app/src/features/chats/domain/usecases/update_message_status.usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> configureChatsFutureDependencies() async {
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl());
  getIt.registerLazySingleton<GetAllConversationUseCase>(
    () => GetAllConversationUseCase(repository: getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<GetConversationUseCase>(
    () => GetConversationUseCase(repository: getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(repository: getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton<UpdateMessageStatusUseCase>(
    () => UpdateMessageStatusUseCase(repository: getIt<ChatRepository>()),
  );
}
