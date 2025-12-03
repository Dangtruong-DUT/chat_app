import 'package:flutter/material.dart';

class ChatDetailScreen extends StatelessWidget {
  final String chatId;
  const ChatDetailScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat Detail $chatId')),
      body: const Center(child: Text('Chat detail content goes here')),
    );
  }
}
