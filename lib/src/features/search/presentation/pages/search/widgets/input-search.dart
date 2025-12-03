import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputSearch extends StatefulWidget {
  const InputSearch({super.key});

  @override
  State<InputSearch> createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  late final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isTextFieldFocus = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        isTextFieldFocus = focusNode.hasFocus;
      });
    });

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
    controller.dispose();
  }

  void _onClearTextField() {
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: isTextFieldFocus
            ? BoxBorder.all(color: Colors.black12, width: 2)
            : BoxBorder.all(color: Colors.black12, width: 2),
        color: isTextFieldFocus ? Colors.white38 : Colors.transparent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/search.svg",
            width: 20,
            height: 20,
            color: Colors.black87,
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              style: theme.textTheme.labelMedium?.copyWith(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: theme.textTheme.labelMedium?.copyWith(
                  color: Colors.black54,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isCollapsed: true,
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            GestureDetector(
              onTap: _onClearTextField,
              child: Icon(Icons.close, size: 18, color: Colors.black54),
            ),
        ],
      ),
    );
  }
}
