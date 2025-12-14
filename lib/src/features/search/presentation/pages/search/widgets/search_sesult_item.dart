import 'package:chat_app/src/core/router/routes.config.dart';
import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchUserResultItem extends StatelessWidget {
  final User user;
  const SearchUserResultItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _onTapItem(context),
      leading: CircleAvatar(
        backgroundImage: user.avatar != null
            ? NetworkImage(user.avatar!)
            : const AssetImage('assets/images/common/avatar_placeholder.gif'),
      ),
      title: Text(user.name, style: TextStyle(overflow: TextOverflow.ellipsis)),
      subtitle: Text(
        user.email,
        style: TextStyle(overflow: TextOverflow.ellipsis),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
    );
  }

  void _onTapItem(BuildContext context) {
    GoRouter.of(context).push(
      Uri(
        path: AppRoutesConfig.chatDetail,
        queryParameters: {ChatDetailRouteQueryKeys.userId: user.id},
      ).toString(),
    );
  }
}
