import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/login/data/login_service_impl.dart';
import 'package:local_ad_view/src/modules/login/interactor/interface/login_service_interface.dart';
import 'package:local_ad_view/src/modules/login/interactor/login_interactor.dart';
import 'package:local_ad_view/src/modules/login/ui/register/resgister_page.dart';
import 'ui/login/login_page.dart';

class LoginModule extends Module {
  @override
  void binds(Injector i) {
    i.add(Logininteractor.new);
    i.add<LoginServiceInterface>(LoginServiceImpl.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/login', child: (context) => const LoginPage());
    r.child('/register', child: (context) => const RegisterPage());
  }
}
