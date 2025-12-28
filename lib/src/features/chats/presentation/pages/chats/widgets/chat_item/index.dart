import 'package:chat_app/src/core/router/routes.config.dart';
import 'package:chat_app/src/core/utils/formatting/timeFormatter/time_ago.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat_summary.entity.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chats/widgets/chat_item/message_status_icon.dart';
import 'package:chat_app/src/shared/presentation/widgets/custom_avatar.dart';
import 'package:easy_localization/easy_localization.dart';
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

    return InkWell(
      onTap: () => _onTapItem(context),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: theme.colorScheme.outline, width: 1),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CustomCircleAvatar(imageUrl: chat.user.avatar),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.user.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _buildSubtitle(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: _hasUnread
                                ? FontWeight.w700
                                : FontWeight.w400,
                            color: _hasUnread
                                ? theme.colorScheme.onSurface
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      if (chat.isLastMessageFromCurrentUser)
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: MessageStatusIcon(
                            status: chat.lastMessageStatus,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _buildSubtitle() {
    final message = chat.lastMessage ?? tr('chats.list.noMessages');
    final time = formatTimeAgo(dateTime: chat.lastUpdated);

    if (chat.isLastMessageFromCurrentUser) {
      return tr(
        'chats.list.subtitle.you',
        namedArgs: {'message': message, 'time': time},
      );
    }
    return tr(
      'chats.list.subtitle.other',
      namedArgs: {'message': message, 'time': time},
    );
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
