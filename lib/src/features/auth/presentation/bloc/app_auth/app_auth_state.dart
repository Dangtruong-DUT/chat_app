import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

sealed class AppAuthState {
  const AppAuthState();
}

class AppAuthenticated extends AppAuthState {
  final User user;
  const AppAuthenticated(this.user);
}

class AppUnauthenticated extends AppAuthState {
  final List<User> loginHistory;
  const AppUnauthenticated({this.loginHistory = const []});
}

class AppAuthLoading extends AppAuthState {
  const AppAuthLoading();
}
