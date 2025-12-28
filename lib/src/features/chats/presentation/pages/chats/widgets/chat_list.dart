import 'package:chat_app/src/features/chats/domain/entities/chat_summary.entity.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chats/widgets/chat_empty_view.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chats/widgets/chat_item/index.dart';
import 'package:flutter/material.dart';

class ChatHistoryList extends StatelessWidget {
  final List<ChatSummary> chats;
  const ChatHistoryList({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    if (chats.isEmpty) {
      return const ChatEmptyView();
    }

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return ChatHistoryListItem(chat: chats[index]);
      },
    );
  }
}
