import 'package:chat_app/src/features/chats/domain/entities/message.entity.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_list_view/incoming_message_bubble.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_list_view/outgoing_message_bubble.dart';
import 'package:flutter/material.dart';

class MessageListView extends StatefulWidget {
  final List<Message> messages;
  final String currentUserId;

  const MessageListView({
    super.key,
    required this.messages,
    required this.currentUserId,
  });

  @override
  State<MessageListView> createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  final ScrollController _scrollController = ScrollController();
  String? _expandedMessageId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void didUpdateWidget(MessageListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages.length != oldWidget.messages.length) {
      _scrollToBottom();
    }
    if (_expandedMessageId != null &&
        !widget.messages.any((msg) => msg.id == _expandedMessageId)) {
      _expandedMessageId = null;
    }
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.messages.isEmpty) {
      return const Center(
        child: Text(
          'Hãy gửi tin nhắn đầu tiên',
          style: TextStyle(color: Colors.black54),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        final message = widget.messages[index];
        final isOutgoing = message.senderId == widget.currentUserId;
        final isExpanded = message.id == _expandedMessageId;
        void handleTap() {
          setState(() {
            _expandedMessageId = isExpanded ? null : message.id;
          });
        }

        return isOutgoing
            ? OutgoingTextMessageBubble(
                message: message,
                isExpanded: isExpanded,
                onTap: handleTap,
              )
            : IncomingTextMessageBubble(
                message: message,
                isExpanded: isExpanded,
                onTap: handleTap,
              );
      },
    );
  }
}
