class AppRoutesConfig {
  AppRoutesConfig._();

  static const splash = '/splash';
  static const auth = '/auth';
  static const login = '/login';
  static const register = '/register';

  static const home = '/';
  static const chats = '/chats';
  static const chatDetail = '/chats/:chatId';
  static const settings = '/settings';
  static const search = '/search';

  static const protected = <String>[chats, chatDetail];
  static const authPages = <String>[login, register, auth];
}
