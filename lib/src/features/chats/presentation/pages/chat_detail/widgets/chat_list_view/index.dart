import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_list_view/incoming_message_bubble.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_list_view/outgoing_message_bubble.dart';
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
