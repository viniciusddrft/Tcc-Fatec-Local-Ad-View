import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/login/ui/register/resgister_page.dart';
import 'ui/login/login_page.dart';

class LoginModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/login', child: (context) => const LoginPage());
    r.child('/register', child: (context) => const RegisterPage());
  }
}
