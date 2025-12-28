import 'package:chat_app/src/features/chats/presentation/bloc/chat_detail/chat_detail_bloc.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chat_detail/chat_detail_event.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chat_detail/chat_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatInputBar extends StatefulWidget {
  const ChatInputBar({super.key});

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  late final TextEditingController _controller;
  bool _canSend = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_handleTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChatDetailBloc, ChatDetailState, ChatDetailSendStatus>(
      selector: (state) => state.sendStatus,
      builder: (context, sendStatus) {
        final isSending = sendStatus == ChatDetailSendStatus.sending;
        final canSubmit = _canSend && !isSending;
        final theme = Theme.of(context);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          color: theme.colorScheme.surface,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    minLines: 1,
                    maxLines: 5,
                    onSubmitted: (_) {
                      if (canSubmit) _sendMessage(context);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Nhập tin nhắn...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 40,
                height: 40,
                child: isSending
                    ? Padding(
                        padding: const EdgeInsets.all(8),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: theme.colorScheme.primary,
                        ),
                      )
                    : IconButton(
                        onPressed: canSubmit
                            ? () => _sendMessage(context)
                            : null,
                        icon: Icon(
                          Icons.send,
                          color: canSubmit
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _canSend) {
      setState(() {
        _canSend = hasText;
      });
    }
  }

  void _sendMessage(BuildContext context) {
    if (context.read<ChatDetailBloc>().state.sendStatus ==
        ChatDetailSendStatus.sending) {
      return;
    }

    final content = _controller.text.trim();
    if (content.isEmpty) return;

    context.read<ChatDetailBloc>().add(ChatDetailMessageSent(content));
    _controller.clear();
  }
}
