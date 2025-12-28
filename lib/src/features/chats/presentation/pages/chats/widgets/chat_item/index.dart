import 'package:chat_app/src/core/router/routes.config.dart';
import 'package:chat_app/src/core/utils/formatting/timeFormatter/time_ago.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat_summary.entity.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chats/widgets/chat_item/message_status_icon.dart';
import 'package:chat_app/src/shared/presentation/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatHistoryListItem extends StatelessWidget {
  final ChatSummary chat;
  const ChatHistoryListItem({required this.chat, super.key});

  bool get _hasUnread =>
      chat.hasUnreadMessages && !chat.isLastMessageFromCurrentUser;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: CustomCircleAvatar(imageUrl: chat.user.avatar),
      title: Text(
        chat.user.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              _buildSubtitle(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: _hasUnread ? FontWeight.w700 : FontWeight.w400,
                color: _hasUnread ? Colors.black87 : Colors.grey[600],
              ),
            ),
          ),
          if (chat.isLastMessageFromCurrentUser)
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: MessageStatusIcon(status: chat.lastMessageStatus),
            ),
        ],
      ),
      onTap: () => _onTapItem(context),
    );
  }

  String _buildSubtitle() {
    final message = chat.lastMessage ?? 'Hãy bắt đầu cuộc trò chuyện';
    final time = formatTimeAgo(dateTime: chat.lastUpdated);

    if (chat.isLastMessageFromCurrentUser) {
      return 'Bạn: $message · $time';
    }
    return '$message · $time';
  }

  void _onTapItem(BuildContext context) {
    context.push(
      Uri(
        path: AppRoutesConfig.chatDetail,
        queryParameters: {
          ChatDetailRouteQueryKeys.chatId: chat.id,
          ChatDetailRouteQueryKeys.userId: chat.user.id,
        },
      ).toString(),
    );
  }
}
