import 'package:chat_app/src/shared/domain/models/user.model.dart';
import 'package:flutter/material.dart';

class AccountInfo extends StatelessWidget {
  final User user;
  const AccountInfo({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 58,
        height: 58,
        child: CircleAvatar(
          backgroundImage: user.avatar != null && user.avatar!.isNotEmpty
              ? NetworkImage(user.avatar!)
              : const AssetImage('assets/images/common/avatar_placeholder.gif')
                    as ImageProvider,
        ),
      ),
      title: Text(
        user.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        user.email,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
