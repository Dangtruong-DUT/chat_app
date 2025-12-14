import 'package:chat_app/src/features/chats/domain/entities/message.entity.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/src/core/utils/formatting/timeFormatter/time_ago.dart';

class IncomingTextMessageBubble extends StatelessWidget {
  final Message message;
  const IncomingTextMessageBubble({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.content),
            SizedBox(height: 2),
            Text(
              formatTimeAgo(dateTime: message.timestamp),
              style: TextStyle(fontSize: 10, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
