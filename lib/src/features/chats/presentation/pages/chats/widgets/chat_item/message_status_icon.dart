import 'package:chat_app/src/features/chats/domain/entities/message_status.enum.dart';
import 'package:flutter/material.dart';

class MessageStatusIcon extends StatelessWidget {
  final MessageStatus? status;
  const MessageStatusIcon({this.status, super.key});

  @override
  Widget build(BuildContext context) {
    if (status == null) return const SizedBox.shrink();

    IconData icon;
    final colorScheme = Theme.of(context).colorScheme;
    Color color = colorScheme.onSurfaceVariant;

    switch (status) {
      case MessageStatus.sent:
        icon = Icons.check;
        break;
      case MessageStatus.delivered:
        icon = Icons.check;
        color = colorScheme.secondary;
        break;
      case MessageStatus.read:
        icon = Icons.done_all;
        color = colorScheme.primary;
        break;
      case null:
        icon = Icons.check;
        break;
    }

    return Icon(icon, size: 16, color: color);
  }
}
