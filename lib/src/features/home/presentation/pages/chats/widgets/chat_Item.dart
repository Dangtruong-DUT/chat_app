import 'package:chat_app/src/shared/domain/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatListItem extends StatelessWidget {
  final User chat;
  const ChatListItem({required this.chat, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: chat.avatar != null && chat.avatar!.isNotEmpty
            ? NetworkImage(chat.avatar!)
            : const AssetImage('assets/images/common/avatar_placeholder.gif')
                  as ImageProvider,
      ),
      title: Text(
        chat.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        chat.email,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onTap: () {
        GoRouter.of(context).push('/chats/${chat.id}');
      },
    );
  }
}
