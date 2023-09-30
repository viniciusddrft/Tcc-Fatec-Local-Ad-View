import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/dashboard/ui/dashboard.dart';

class DashboardModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/dashboard', child: (context) => const DashboardPage());
  }
}
