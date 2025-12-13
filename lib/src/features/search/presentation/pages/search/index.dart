import 'package:chat_app/src/features/search/presentation/bloc/search_bloc.dart';
import 'package:chat_app/src/features/search/presentation/pages/search/widgets/input_search.dart';
import 'package:chat_app/src/features/search/presentation/pages/search/widgets/search_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBlocProvider(
      child: Scaffold(
        appBar: AppBar(title: const Text("Search")),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                InputSearch(),
                SizedBox(height: 16),
                Expanded(child: SearchResults()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBlocProvider({required Widget child}) {
    return BlocProvider(
      create: (_) => GetIt.instance<SearchBloc>(),
      child: child,
    );
  }
}
