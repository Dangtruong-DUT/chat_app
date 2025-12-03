import 'package:chat_app/src/features/search/presentation/pages/search/widgets/input-search.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: const [InputSearch()]),
        ),
      ),
    );
  }
}
