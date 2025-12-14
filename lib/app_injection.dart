import 'package:chat_app/src/core/utils/injection_module/base_injection_module.dart';
import 'package:chat_app/src/features/auth/auth_injection.dart';
import 'package:chat_app/src/features/chats/chats_injection.dart';
import 'package:chat_app/src/features/search/search_injection.dart';
import 'package:chat_app/src/features/setting/setting_injection.dart';
import 'package:chat_app/src/shared/shared_injection.dart';

final List<BaseInjectionModule> featureDependencies = [
  AuthInjectionModule(),
  ChatsInjectionModule(),
  SearchInjectionModule(),
  SettingInjectionModule(),
];

class AppInjectionModule implements BaseInjectionModule {
  @override
  Future<void> register() async {
    await SharedInjectionModule().register();
    await Future.wait(featureDependencies.map((module) => module.register()));
  }
}
