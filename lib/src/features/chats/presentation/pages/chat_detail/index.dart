import 'package:chat_app/_mock/index.dart';
import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_app_bar.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_input_bar.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_list_view/index.dart';
import 'package:flutter/material.dart';

class ChatDetailScreen extends StatelessWidget {
  final String? chatId;
  final String? userId;
  const ChatDetailScreen({super.key, required this.chatId, this.userId});

  @override
  Widget build(BuildContext context) {
    Logger.debug('ChatDetailScreen - chatId: $chatId, userId: $userId');
    return Scaffold(
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
    );
  }
}
