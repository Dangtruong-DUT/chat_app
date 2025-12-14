import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

sealed class AppAuthState {
  const AppAuthState();
}

class AppAuthenticated extends AppAuthState {
  final User user;
  const AppAuthenticated(this.user);
}

class AppUnauthenticated extends AppAuthState {
  const AppUnauthenticated();
}

class AppAuthLoading extends AppAuthState {
  const AppAuthLoading();
}
