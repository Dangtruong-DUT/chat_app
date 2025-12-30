import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chat_detail/chat_detail_bloc.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chat_detail/chat_detail_event.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chats/chats_bloc.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chats/chats_event.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ChatDetailScreen extends StatefulWidget {
  final String? chatId;
  final String? receiverId;

  const ChatDetailScreen({super.key, this.chatId, this.receiverId});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  String? _currentUserId;

  @override
  void dispose() {
    if (_currentUserId != null) {
      _reloadChats(_currentUserId!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AppAuthBloc>().state;
    final currentUser = authState.user;

    if (currentUser == null) {
      return Center(child: Text("Not authenticated"));
    }

    _currentUserId = currentUser.id;

    return BlocProvider(
      create: (_) => GetIt.instance<ChatDetailBloc>(param1: currentUser.id)
        ..add(
          ChatDetailStarted(chatId: widget.chatId, peerId: widget.receiverId),
        ),
      child: ChatDetailView(
        chatId: widget.chatId,
        receiverId: widget.receiverId,
        currentUserId: currentUser.id,
      ),
    );
  }

  void _reloadChats(String userId) {
    if (!GetIt.instance.isRegistered<ChatsBloc>()) return;
    final chatsBloc = GetIt.instance<ChatsBloc>();
    if (chatsBloc.isClosed) return;
    chatsBloc.add(ChatsLoad(userId: userId));
  }
}
