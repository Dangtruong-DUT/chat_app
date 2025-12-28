import 'package:chat_app/src/features/search/presentation/bloc/search_bloc.dart';
import 'package:chat_app/src/features/search/presentation/bloc/search_event.dart';
import 'package:chat_app/src/features/search/presentation/bloc/search_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputSearch extends StatefulWidget {
  const InputSearch({super.key});

  @override
  State<InputSearch> createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  late final TextEditingController inputSearchController =
      TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isTextFieldFocus = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isTextFieldFocus
              ? theme.colorScheme.primary
              : theme.colorScheme.outline,
          width: isTextFieldFocus ? 2 : 1.5,
        ),
        boxShadow: isTextFieldFocus
            ? [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/search.svg",
            width: 25,
            height: 25,
            colorFilter: ColorFilter.mode(
              isTextFieldFocus
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: _onInputSearchChanged,
              controller: inputSearchController,
              focusNode: focusNode,
              style: theme.textTheme.labelMedium?.copyWith(),
              decoration: InputDecoration(
                hintText: tr('search.input.hint'),
                hintStyle: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isCollapsed: true,
              ),
            ),
          ),
          BlocSelector<SearchBloc, SearchState, bool>(
            selector: (state) => state is SearchLoading,
            builder: (context, isLoading) {
              if (isLoading) {
                return SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                );
              }

              if (inputSearchController.text.trim().isNotEmpty) {
                return GestureDetector(
                  onTap: _onClearTextField,
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        isTextFieldFocus = focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
    inputSearchController.dispose();
  }

  void _onInputSearchChanged(String value) {
    inputSearchController.text = value.trim();
    final query = value.trim();

    if (query.isEmpty) {
      _onClearTextField();
      return;
    }

    BlocProvider.of<SearchBloc>(
      context,
      listen: false,
    ).add(SearchRequested(query: value));
  }

  void _onClearTextField() {
    inputSearchController.clear();

    BlocProvider.of<SearchBloc>(
      context,
      listen: false,
    ).add(const SearchCleared());
  }
}
