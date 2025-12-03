import 'package:flutter/material.dart';
import 'widgets/chat_list.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Expanded(child: ChatList())],
      ),
    );
  }
}
