sealed class SearchEvent {
  const SearchEvent();
}

class SearchRequested extends SearchEvent {
  final String query;
  const SearchRequested({required this.query});
}

class SearchCleared extends SearchEvent {
  const SearchCleared();
}
