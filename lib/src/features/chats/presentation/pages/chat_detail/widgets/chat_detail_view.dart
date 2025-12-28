import 'package:chat_app/src/features/chats/data/datasources/user_local_data_source.dart';
import 'package:chat_app/src/features/chats/domain/entities/chat.entity.dart';
import 'package:chat_app/src/features/chats/domain/entities/message_status.enum.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chat_detail/chat_detail_bloc.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chat_detail/chat_detail_event.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chat_detail/chat_detail_state.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chats/chats_bloc.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chats/chats_event.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chats/chats_state.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_app_bar.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_detail_error.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_input_bar.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_list_view/index.dart';
import 'package:chat_app/src/shared/domain/entities/user.entity.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

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
  late final TextEditingController _messageController;
  User? _partnerUser;
  String? _receiverId;
  String? _lastMarkedChatId;
  int _lastMarkedUnread = 0;
  bool _isFetchingPartner = false;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _receiverId = widget.receiverId;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ChatDetailBloc>().add(
        ChatDetailRequested(
          chatId: widget.chatId,
          currentUserId: widget.currentUserId,
          receiverId: _receiverId,
        ),
      );
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: ChatAppBar(user: _partnerUser)),
      body: SafeArea(
        child: BlocConsumer<ChatDetailBloc, ChatDetailState>(
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) => _handleStateChanges(context, state),
          builder: (context, state) {
            final chat = _extractChat(state);
            if (state is ChatDetailLoading || chat == null) {
              if (state is ChatDetailLoadFailure) {
                return ChatDetailErrorView(
                  message: state.error.message,
                  onRetry: () => _retryLoad(context, widget.currentUserId),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }

            final isSending = state is ChatDetailSending;
            return Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/chats/chat_background.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: MessageListView(
                      messages: chat.messages,
                      currentUserId: widget.currentUserId,
                    ),
                  ),
                ),
                ChatInputBar(
                  controller: _messageController,
                  isSending: isSending,
                  onSend: () =>
                      _onSendMessage(context, chat.id, widget.currentUserId),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleStateChanges(BuildContext context, ChatDetailState state) {
    if (state is ChatDetailLoadFailure) {
      _showSnackBar(context, state.error.message);
    } else if (state is ChatDetailSendFailure) {
      _showSnackBar(context, state.error.message);
    }

    final chat = _extractChat(state);
    if (chat == null) return;

    _capturePartner(chat, widget.currentUserId);
    _markMessagesReadIfNeeded(context, chat, widget.currentUserId);

    if (state is ChatDetailLoaded) {
      _syncChatsList(widget.currentUserId);
    }
  }

  void _onSendMessage(
    BuildContext context,
    String chatId,
    String currentUserId,
  ) {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;
    final receiverId = _receiverId ?? _partnerUser?.id;
    if (receiverId == null) return;

    context.read<ChatDetailBloc>().add(
      ChatDetailMessageSent(
        chatId: chatId,
        currentUserId: currentUserId,
        receiverId: receiverId,
        content: content,
      ),
    );

    _messageController.clear();
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Chat? _extractChat(ChatDetailState state) {
    if (state is ChatDetailLoaded) return state.chat;
    if (state is ChatDetailSending) return state.chat;
    if (state is ChatDetailSendFailure) return state.chat;
    return null;
  }

  void _capturePartner(Chat chat, String currentUserId) {
    final partnerId = chat.addedUserIds.firstWhere(
      (id) => id != currentUserId,
      orElse: () => _receiverId ?? currentUserId,
    );

    _receiverId ??= partnerId;
    final resolvedUser = _findPartnerFromChatsState(chat.id, partnerId);

    if (resolvedUser != null) {
      if (_partnerUser?.id == resolvedUser.id &&
          _partnerUser?.name == resolvedUser.name &&
          _partnerUser?.email == resolvedUser.email &&
          _partnerUser?.avatar == resolvedUser.avatar) {
        return;
      }
      setState(() => _partnerUser = resolvedUser);
      return;
    }

    if (_partnerUser != null && _partnerUser!.id == partnerId) return;

    setState(() {
      _partnerUser = User(
        id: partnerId,
        name: 'Người dùng',
        email: 'user_$partnerId@chat.app',
      );
    });

    _tryLoadPartnerUser(partnerId);
  }

  void _markMessagesReadIfNeeded(
    BuildContext context,
    Chat chat,
    String currentUserId,
  ) {
    final unreadCount = chat.messages
        .where(
          (msg) =>
              msg.receiverId == currentUserId &&
              msg.status != MessageStatus.read,
        )
        .length;

    if (unreadCount == 0) return;
    if (_lastMarkedChatId == chat.id && _lastMarkedUnread == unreadCount) {
      return;
    }

    _lastMarkedChatId = chat.id;
    _lastMarkedUnread = unreadCount;

    context.read<ChatDetailBloc>().add(
      ChatDetailMarkMessagesRead(chatId: chat.id, currentUserId: currentUserId),
    );
  }

  void _retryLoad(BuildContext context, String currentUserId) {
    context.read<ChatDetailBloc>().add(
      ChatDetailRequested(
        chatId: widget.chatId,
        currentUserId: currentUserId,
        receiverId: _receiverId,
      ),
    );
  }

  void _syncChatsList(String currentUserId) {
    if (!GetIt.instance.isRegistered<ChatsBloc>()) return;
    final chatsBloc = GetIt.instance<ChatsBloc>();
    if (chatsBloc.isClosed) return;
    chatsBloc.add(ChatsLoad(userId: currentUserId));
  }

  User? _findPartnerFromChatsState(String chatId, String partnerId) {
    if (!GetIt.instance.isRegistered<ChatsBloc>()) return null;
    final chatsBloc = GetIt.instance<ChatsBloc>();
    final state = chatsBloc.state;
    if (state is! ChatsLoaded) return null;

    for (final summary in state.chats) {
      if (summary.id == chatId || summary.user.id == partnerId) {
        return summary.user;
      }
    }
    return null;
  }

  Future<void> _tryLoadPartnerUser(String partnerId) async {
    if (_isFetchingPartner) return;
    if (!GetIt.instance.isRegistered<UserLocalDataSource>()) return;

    _isFetchingPartner = true;
    try {
      final dataSource = GetIt.instance<UserLocalDataSource>();
      final users = await dataSource.getAllUsers();
      final match = users.firstWhereOrNull((user) => user.id == partnerId);
      if (match != null && mounted) {
        setState(() => _partnerUser = match.toEntity());
      }
    } catch (_) {
      // ignore, fallback stays on screen
    } finally {
      _isFetchingPartner = false;
    }
  }
}
