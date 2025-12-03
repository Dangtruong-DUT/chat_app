import 'package:flutter/material.dart';

class MessageListView extends StatelessWidget {
  const MessageListView({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      children: [
        OutgoingTextMessageBubble(text: "Japan looks amazing!", time: "10:10"),

        IncomingTextMessageBubble(
          text: "Do you know what time it is?",
          time: "11:40",
        ),
        OutgoingTextMessageBubble(
          text: "It's morning in Tokyo 😎",
          time: "11:43",
        ),
        IncomingTextMessageBubble(
          text: "What is the most popular meal in Japan?\nDo you like it?",
          time: "11:45",
        ),
      ],
    );
  }
}

class OutgoingTextMessageBubble extends StatelessWidget {
  final String text, time;
  const OutgoingTextMessageBubble({
    required this.text,
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xffDCF8C6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(text),
            SizedBox(height: 2),
            Text(time, style: TextStyle(fontSize: 10, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}

class IncomingTextMessageBubble extends StatelessWidget {
  final String text, time;
  const IncomingTextMessageBubble({
    required this.text,
    required this.time,
    super.key,
  });

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
            Text(text),
            SizedBox(height: 2),
            Text(time, style: TextStyle(fontSize: 10, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
