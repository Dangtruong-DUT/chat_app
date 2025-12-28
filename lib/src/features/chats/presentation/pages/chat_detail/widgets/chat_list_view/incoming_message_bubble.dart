import 'package:chat_app/src/core/utils/formatting/timeFormatter/time_ago.dart';
import 'package:chat_app/src/features/chats/domain/entities/message.entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class IncomingTextMessageBubble extends StatelessWidget {
  final Message message;
  final bool isExpanded;
  final VoidCallback onTap;

  const IncomingTextMessageBubble({
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
        ? colorScheme.surfaceContainerHighest
        : colorScheme.surface;
    final timestampText = formatTimeAgo(
      dateTime: message.timestamp,
      locale: context.locale.languageCode,
    );
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
              color: colorScheme.shadow.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.content),
            const SizedBox(height: 2),
            Text(timestampText, style: metaStyle),
          ],
        ),
      ),
    );

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          bubble,
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(top: 2, left: 4),
              child: Text(
                tr(
                  'chats.detail.receivedAt',
                  namedArgs: {'time': timestampText},
                ),
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
}
