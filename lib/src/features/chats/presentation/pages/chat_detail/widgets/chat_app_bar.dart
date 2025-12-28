import 'package:chat_app/src/shared/domain/entities/user.entity.dart';
import 'package:chat_app/src/shared/presentation/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User? user;
  const ChatAppBar({this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          if (user == null) return;
          GoRouter.of(context).push('/chats/${user!.id}');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      user?.name ?? 'Đang tải...',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.right,
                    ),
                  ),

                  SizedBox(
                    width: 200,
                    child: Text(
                      user?.email ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 36,
              height: 36,
              child: CustomCircleAvatar(imageUrl: user?.avatar),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
