import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/dashboard/data/dashboard_service_impl.dart';
import 'package:local_ad_view/src/modules/dashboard/interactor/dashboard_interactor.dart';
import 'package:local_ad_view/src/modules/dashboard/interactor/interface/dashboard_service_interface.dart';
import 'package:local_ad_view/src/modules/dashboard/ui/dashboard/dashboard_page.dart';
import 'package:local_ad_view/src/modules/dashboard/ui/onboarding/onboarding_add_ad_page.dart';

class DashboardModule extends Module {
  @override
  void binds(Injector i) {
    i.add(DashboardInteractor.new);
    i.add<DashboardServiceInterface>(DashboardServiceImpl.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/dashboard', child: (context) => const DashboardPage());
    r.child('/onboarding', child: (context) => const OnboardingPage());
  }
}
