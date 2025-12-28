import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String? imageUrl;
  final double? radius;

  const CustomCircleAvatar({super.key, required this.imageUrl, this.radius});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
          ? NetworkImage(imageUrl!)
          : const AssetImage('assets/images/common/avatar_placeholder.gif'),
    );
  }
}
