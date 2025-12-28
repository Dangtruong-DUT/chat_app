import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat_summary.entity.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chats/chats_bloc.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chats/chats_event.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chats/chats_state.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chats/widgets/chat_error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'widgets/chat_list.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AppAuthBloc>().state;
    final userId = authState.user?.id;

    return _buildBlocProvider(
      userId: userId!,
      child: Scaffold(
        appBar: AppBar(title: const Text('Tin nhắn')),
        body: BlocConsumer<ChatsBloc, ChatsState>(
          listenWhen: (previous, current) =>
              previous.runtimeType != current.runtimeType &&
              current is ChatsLoadFailure,
          listener: (context, state) {
            if (state is ChatsLoadFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(state.error.message)));
            }
          },
          builder: (context, state) {
            if (state is ChatsLoading || state is ChatsInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ChatsLoadFailure) {
              return ChatsErrorView(
                message: state.error.message,
                onRetry: () => _onReload(context, userId),
              );
            }

            final chats = (state is ChatsLoaded)
                ? state.chats
                : <ChatSummary>[];

            return RefreshIndicator(
              onRefresh: () async => _onReload(context, userId),
              child: ChatHistoryList(chats: chats),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBlocProvider({required Widget child, required String userId}) {
    return BlocProvider<ChatsBloc>.value(
      value: GetIt.instance<ChatsBloc>()..add(ChatsLoad(userId: userId)),
      child: child,
    );
  }

  Future<void> _onReload(BuildContext context, String userId) async {
    context.read<ChatsBloc>().add(ChatsLoad(userId: userId));
  }
}
