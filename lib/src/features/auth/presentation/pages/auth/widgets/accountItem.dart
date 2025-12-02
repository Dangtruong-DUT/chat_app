import 'package:chat_app/src/shared/domain/models/user.model.dart';
import 'package:flutter/material.dart';

class AccountItem extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;
  const AccountItem({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircleAvatar(
                backgroundImage: user.avatar != null
                    ? NetworkImage(user.avatar!)
                    : AssetImage('assets/images/common/avatar_placeholder.gif'),
              ),
            ),

            const SizedBox(height: 8),
            Text(
              user.name,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(overflow: TextOverflow.ellipsis),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
