import 'package:chat_app/src/core/utils/formatting/timeFormatter/time_ago.dart';
import 'package:chat_app/src/features/chats/domain/entities/message.entity.dart';
import 'package:chat_app/src/features/chats/domain/entities/message_status.enum.dart';
import 'package:flutter/material.dart';

class OutgoingTextMessageBubble extends StatelessWidget {
  final Message message;
  final bool isExpanded;
  final VoidCallback onTap;

  const OutgoingTextMessageBubble({
    required this.message,
    required this.isExpanded,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bubbleColor = isExpanded
        ? colorScheme.surfaceVariant
        : colorScheme.surface;
    final metaStyle = theme.textTheme.bodySmall?.copyWith(
      fontSize: 10,
      color: colorScheme.onSurfaceVariant,
    );
    final bubble = GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(message.content),
            const SizedBox(height: 2),
            Text(formatTimeAgo(dateTime: message.timestamp), style: metaStyle),
          ],
        ),
      ),
    );

    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          bubble,
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(top: 2, right: 4),
              child: Text(
                '${_statusLabel(message.status)} · ${formatTimeAgo(dateTime: message.timestamp)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 11,
                  color: colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _statusLabel(MessageStatus status) {
    switch (status) {
      case MessageStatus.sent:
        return 'Đã gửi';
      case MessageStatus.delivered:
        return 'Đã nhận';
      case MessageStatus.read:
        return 'Đã xem';
    }
  }
}
