import 'package:flutter/material.dart';

class ChatItem {
  final String avatarUrl;
  final String name;
  final String lastMessage;
  final String time;

  ChatItem({
    required this.avatarUrl,
    required this.name,
    required this.lastMessage,
    required this.time,
  });
}

class ChatListScreen extends StatelessWidget {
  final List<ChatItem> chatItems = [
    ChatItem(
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      name: 'Tabitha Potter',
      lastMessage:
          'Actually I wanted to check with you about your online business plan on our...',
      time: '8/25/19',
    ),
    ChatItem(
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      name: 'John Doe',
      lastMessage: 'Hey, are we still on for tomorrow?',
      time: '8/24/19',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chats')),
      body: ListView.builder(
        itemCount: chatItems.length,
        itemBuilder: (context, index) {
          final chat = chatItems[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chat.avatarUrl),
            ),
            title: Text(
              chat.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              chat.lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              chat.time,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}
