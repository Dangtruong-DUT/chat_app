import 'package:chat_app/src/core/router/routes.config.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat_summary.entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatHistoryListItem extends StatelessWidget {
  final ChatSummary chat;
  const ChatHistoryListItem({required this.chat, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage:
            chat.user.avatar != null && chat.user.avatar!.isNotEmpty
            ? NetworkImage(chat.user.avatar!)
            : const AssetImage('assets/images/common/avatar_placeholder.gif')
                  as ImageProvider,
      ),
      title: Text(
        chat.user.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        chat.user.email,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () => _onTapItem(context),
    );
  }

  void _onTapItem(BuildContext context) {
    GoRouter.of(context).push(
      Uri(
        path: AppRoutesConfig.chatDetail,
        queryParameters: {ChatDetailRouteQueryKeys.chatId: chat.id},
      ).toString(),
    );
  }
}
