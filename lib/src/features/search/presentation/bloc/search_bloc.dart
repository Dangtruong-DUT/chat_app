import 'package:bloc/bloc.dart';
import 'package:chat_app/src/core/bloc/debounce.dart';
import 'package:chat_app/src/features/search/domain/usecases/search_users.usecase.dart';
import 'package:chat_app/src/features/search/presentation/bloc/search_event.dart';
import 'package:chat_app/src/features/search/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUserUseCase _searchUserUseCase;

  SearchBloc({required SearchUserUseCase searchUserUseCase})
    : _searchUserUseCase = searchUserUseCase,
      super(const SearchInitial()) {
    on<SearchRequested>(
      _onSearchRequested,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
    on<SearchCleared>(_onSearchCleared);
  }

  Future<void> _onSearchRequested(
    SearchRequested event,
    Emitter<SearchState> emit,
  ) async {
    emit(const SearchLoading());
    final searchUseCaseParams = SearchUserUseCaseParams(query: event.query);
    final result = await _searchUserUseCase.call(searchUseCaseParams);
    result.fold(
      (_) => emit(const SearchLoaded(results: [])),
      (users) => emit(SearchLoaded(results: users)),
    );
  }

  void _onSearchCleared(SearchCleared event, Emitter<SearchState> emit) {
    emit(const SearchInitial());
  }
}
