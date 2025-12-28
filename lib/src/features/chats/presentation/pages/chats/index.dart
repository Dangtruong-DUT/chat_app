import 'package:chat_app/src/features/chats/presentation/bloc/chats/chats_bloc.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chats/chats_event.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'widgets/chat_list.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBlocProvider(
      child: Scaffold(
        appBar: AppBar(title: const Text('Chats')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Expanded(child: ChatHistoryList(chats: []))],
        ),
      ),
    );
  }

  Widget _buildBlocProvider({required Widget child}) {
    return BlocProvider<ChatsBloc>(
      create: (context) {
        final authState = context.read<AppAuthBloc>().state;
        final userId = authState.user?.id;
        final bloc = GetIt.instance<ChatsBloc>();
        if (userId == null) {
          return bloc;
        }
        return bloc..add(ChatsLoad(userId: userId));
      },
      child: child,
    );
  }
}
