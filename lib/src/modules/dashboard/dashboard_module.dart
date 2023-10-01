import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/dashboard/data/dashboard_service_impl.dart';
import 'package:local_ad_view/src/modules/dashboard/interector/dashboard_interector.dart';
import 'package:local_ad_view/src/modules/dashboard/interector/interface/dashboard_service_interface.dart';
import 'package:local_ad_view/src/modules/dashboard/ui/dashboard.dart';

class DashboardModule extends Module {
  @override
  void binds(Injector i) {
    i.add(DashboardInterector.new);
    i.add<DashboardServiceInterface>(DashboardServiceImpl.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/dashboard', child: (context) => const DashboardPage());
  }
}
