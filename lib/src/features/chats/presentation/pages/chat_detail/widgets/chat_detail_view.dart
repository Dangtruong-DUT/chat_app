import 'package:chat_app/src/features/chats/domain/entities/chat.entity.dart';
import 'package:chat_app/src/features/chats/domain/entities/message_status.enum.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chat_detail/chat_detail_bloc.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chat_detail/chat_detail_event.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chat_detail/chat_detail_state.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_app_bar.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_detail_error.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_input_bar.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_list_view/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailView extends StatefulWidget {
  final String? chatId;
  final String? receiverId;
  final String currentUserId;

  const ChatDetailView({
    super.key,
    required this.currentUserId,
    this.chatId,
    this.receiverId,
  });

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ChatDetailBloc, ChatDetailState>(
          buildWhen: (prev, curr) => prev.partner != curr.partner,
          builder: (_, state) => ChatAppBar(user: state.partner),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<ChatDetailBloc, ChatDetailState>(
          listener: (context, state) => _handleStateChanges(context, state),
          builder: (context, state) {
            final chat = state.chat;
            if (state.status == ChatDetailStatus.loading && chat == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.loadError != null && chat == null) {
              return ChatDetailErrorView(
                message: state.loadError!.message,
                onRetry: () => _retryLoad(context),
              );
            }

            if (chat == null) {
              return const SizedBox.shrink();
            }

            final theme = Theme.of(context);
            final backgroundAsset =
                theme.colorScheme.brightness == Brightness.dark
                ? 'assets/images/chats/dark_background.png'
                : 'assets/images/chats/chat_background.png';

            return Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(backgroundAsset),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: MessageListView(
                      messages: chat.messages,
                      currentUserId: widget.currentUserId,
                    ),
                  ),
                ),
                const ChatInputBar(),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleStateChanges(BuildContext context, ChatDetailState state) {
    if (state.loadError != null && state.chat != null) {
      _showSnackBar(context, state.loadError!.message);
    }

    if (state.sendError != null) {
      _showSnackBar(context, state.sendError!.message);
    }

    final chat = state.chat;
    if (chat == null) return;

    _markMessagesReadIfNeeded(context, chat, widget.currentUserId);
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _markMessagesReadIfNeeded(
    BuildContext context,
    Chat chat,
    String currentUserId,
  ) {
    final hasUnread = chat.messages.any(
      (msg) =>
          msg.receiverId == currentUserId &&
          msg.status != MessageStatus.read &&
          msg.senderId != currentUserId,
    );

    if (!hasUnread) return;

    context.read<ChatDetailBloc>().add(const ChatDetailMessagesMarkedRead());
  }

  void _retryLoad(BuildContext context) {
    final partnerId = context.read<ChatDetailBloc>().state.partner?.id;
    context.read<ChatDetailBloc>().add(
      ChatDetailStarted(
        chatId: widget.chatId,
        peerId: partnerId ?? widget.receiverId,
      ),
    );
  }
}
