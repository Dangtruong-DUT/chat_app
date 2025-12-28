import 'package:chat_app/src/core/utils/injection_module/base_injection_module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _getIt = GetIt.instance;

class SharedInjectionModule implements BaseInjectionModule {
  @override
  Future<void> register() async {
    await _configureDataSourceDependencies();
  }

  Future<void> _configureDataSourceDependencies() async {
    final store = await SharedPreferences.getInstance();
    _getIt.registerLazySingleton<SharedPreferences>(() => store);
  }
}
