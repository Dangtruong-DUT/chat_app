import 'package:flutter/material.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Message",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.send, color: Colors.grey),
        ],
      ),
    );
  }
}
