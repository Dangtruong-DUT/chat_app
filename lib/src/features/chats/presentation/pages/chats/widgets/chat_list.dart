import 'package:chat_app/_mock/index.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chats/widgets/chat_Item.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        final chat = usersMockData[index];
        return ChatListItem(chat: chat);
      },
    );
  }
}
