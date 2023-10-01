import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/dashboard/dashboard_module.dart';
import 'package:local_ad_view/src/modules/login/login_module.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [LoginModule()];

  @override
  void routes(RouteManager r) {
    r.module('/', module: HomeModule());
    r.module('/login', module: LoginModule());
    r.module('/dashboard', module: DashboardModule());
  }
}
