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
    final bubble = GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isExpanded ? const Color(0xffcfeec1) : const Color(0xffDCF8C6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(message.content),
            const SizedBox(height: 2),
            Text(
              formatTimeAgo(dateTime: message.timestamp),
              style: const TextStyle(fontSize: 10, color: Colors.black54),
            ),
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
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
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
