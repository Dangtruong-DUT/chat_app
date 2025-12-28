import 'package:chat_app/src/features/chats/domain/entities/message_status.enum.dart';
import 'package:flutter/material.dart';

class MessageStatusIcon extends StatelessWidget {
  final MessageStatus? status;
  const MessageStatusIcon({this.status, super.key});

  @override
  Widget build(BuildContext context) {
    if (status == null) return const SizedBox.shrink();

    IconData icon;
    Color color = Colors.grey;

    switch (status) {
      case MessageStatus.sent:
        icon = Icons.check;
        break;
      case MessageStatus.delivered:
        icon = Icons.check;
        break;
      case MessageStatus.read:
        icon = Icons.done_all;
        color = const Color(0xFF1877F2);
        break;
      case null:
        icon = Icons.check;
        break;
    }

    return Icon(icon, size: 16, color: color);
  }
}
