import 'package:chat_app/src/core/router/routes.config.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:chat_app/src/features/chats/presentation/bloc/chat_detail/chat_detail_bloc.dart';
import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/widgets/chat_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ChatDetailScreen extends StatelessWidget {
  final String? chatId;
  final String? receiverId;

  const ChatDetailScreen({super.key, this.chatId, this.receiverId});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AppAuthBloc>().state;
    final currentUser = authState.user;

    if (currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        GoRouter.of(context).go(AppRoutesConfig.auth);
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return BlocProvider(
      create: (_) => GetIt.instance<ChatDetailBloc>(),
      child: ChatDetailView(
        chatId: chatId,
        receiverId: receiverId,
        currentUserId: currentUser.id,
      ),
    );
  }
}
