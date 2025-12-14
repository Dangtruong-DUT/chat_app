import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

sealed class AuthHistoryState {
  const AuthHistoryState();
}

class AuthHistoryInitial extends AuthHistoryState {
  const AuthHistoryInitial();
}

class AuthHistoryLoading extends AuthHistoryState {
  const AuthHistoryLoading();
}

class AuthHistoryLoaded extends AuthHistoryState {
  final List<User> history;
  const AuthHistoryLoaded({required this.history});
}
