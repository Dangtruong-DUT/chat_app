import 'package:chat_app/src/core/router/routes.config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatEmptyView extends StatelessWidget {
  const ChatEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No chats available, let's start a new conversation!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
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

  void _onSearchUsersTap(BuildContext context) {
    GoRouter.of(context).push(AppRoutesConfig.search);
  }
}
