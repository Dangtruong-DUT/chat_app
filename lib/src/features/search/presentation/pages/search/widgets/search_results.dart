import 'package:chat_app/src/features/search/presentation/bloc/search_bloc.dart';
import 'package:chat_app/src/features/search/presentation/bloc/search_state.dart';
import 'package:chat_app/src/features/search/presentation/pages/search/widgets/search_sesult_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          return Center(
            child: Lottie.asset(
              'assets/lotties/search_icon.json',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          );
        }
        if (state is SearchLoaded) {
          return state.results.isNotEmpty
              ? ListView.builder(
                  itemCount: state.results.length,
                  itemBuilder: (context, index) {
                    return SearchUserResultItem(user: state.results[index]);
                  },
                )
              : Center(
                  child: Text(
                    "No users found",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
        }
        return SizedBox();
      },
    );
  }
}
