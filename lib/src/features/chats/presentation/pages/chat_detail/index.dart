import 'package:chat_app/_mock/index.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chatDetail/chat_detail_bloc.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_app_bar.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_input_bar.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_list_view/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ChatDetailScreen extends StatelessWidget {
  final String? chatId;
  final String? userId;
  const ChatDetailScreen({super.key, required this.chatId, this.userId});

  @override
  Widget build(BuildContext context) {
    return _buildBlocProvider(
      child: Scaffold(
        appBar: AppBar(title: ChatAppBar(user: usersMockData[0])),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/chats/chat_background.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: MessageListView(),
                ),
              ),
              ChatInputBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlocProvider({required Widget child}) {
    return BlocProvider(
      create: (_) => GetIt.instance<ChatDetailBloc>(),
      child: child,
    );
  }
}
