import 'package:chat_app/src/core/utils/formatting/timeFormatter/time_ago.dart';
import 'package:chat_app/src/features/chats/domain/entities/message.entity.dart';
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
    final bubble = GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isExpanded ? Colors.grey.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                'Đã nhận lúc ${formatTimeAgo(dateTime: message.timestamp)}',
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
}
