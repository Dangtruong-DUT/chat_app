import 'package:chat_app/src/features/chats/domain/models/chat_summary.model.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chats/widgets/chat_Item.dart';
import 'package:flutter/material.dart';

class ChatHistoryList extends StatelessWidget {
  final List<ChatSummary> chats;
  const ChatHistoryList({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return ChatHistoryListItem(chat: chats[index]);
      },
    );
  }
}
