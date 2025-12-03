class AppRoutesConfig {
  AppRoutesConfig._();

  static const splash = '/splash';
  static const auth = '/auth';
  static const login = '/auth/login';
  static const register = '/auth/register';

  static const chats = '/chats';
  static const settings = '/settings';
  static const chatDetail = '/chats/:chatId';
  static const search = '/search';

  static const protected = <String>[chats, chatDetail];
  static const authPages = <String>[login, register, auth];
}
