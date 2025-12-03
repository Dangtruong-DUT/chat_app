import 'package:flutter/material.dart';

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
