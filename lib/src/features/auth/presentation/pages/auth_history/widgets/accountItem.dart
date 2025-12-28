import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';
import 'package:chat_app/src/shared/presentation/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';

class AccountItem extends StatefulWidget {
  final User user;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const AccountItem({super.key, required this.user, this.onTap, this.onDelete});

  @override
  State<AccountItem> createState() => _AccountItemState();
}

class _AccountItemState extends State<AccountItem>
    with SingleTickerProviderStateMixin {
  bool showDelete = false;

  late AnimationController _controller;
  late Animation<double> _shake;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _shake = Tween<double>(
      begin: -0.5,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && showDelete) {
        _hideDeleteIcon();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _showDeleteIcon() {
    _focusNode.requestFocus();
    setState(() => showDelete = true);
    _controller.repeat(reverse: true);
  }

  void _hideDeleteIcon() {
    _focusNode.unfocus();
    setState(() => showDelete = false);
    _controller.stop();
    _controller.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _hideDeleteIcon();
          widget.onTap?.call();
        },
        onLongPress: _showDeleteIcon,
        child: SizedBox(
          width: 60,
          child: Column(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: CustomCircleAvatar(imageUrl: widget.user.avatar),
                    ),

                    if (showDelete)
                      Positioned(
                        right: -4,
                        top: -4,
                        child: AnimatedBuilder(
                          animation: _shake,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(_shake.value, 0),
                              child: child,
                            );
                          },
                          child: GestureDetector(
                            onTap: () {
                              _hideDeleteIcon();
                              widget.onDelete?.call();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              Text(
                widget.user.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
