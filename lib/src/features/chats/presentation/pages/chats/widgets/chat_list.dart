import 'package:chat_app/src/features/chats/domain/models/chat_summary.model.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chats/widgets/chat_Item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatHistoryList extends StatelessWidget {
  final List<ChatSummary> chats;
  const ChatHistoryList({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    if (chats.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "No chats available, let's start a new conversation!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => _onSearchUsersTap(context),
              child: const Text("Search users for new chats"),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return ChatHistoryListItem(chat: chats[index]);
      },
    );
  }

  void _onSearchUsersTap(BuildContext context) {
    GoRouter.of(context).push('/search');
  }
}
