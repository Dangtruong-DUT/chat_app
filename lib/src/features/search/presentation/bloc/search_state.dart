import 'package:chat_app/src/shared/domain/models/user.model.dart';

sealed class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchLoaded extends SearchState {
  final List<User> results;
  const SearchLoaded({required this.results});
}
