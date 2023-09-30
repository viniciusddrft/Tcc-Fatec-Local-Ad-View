import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/home/data/home_service_impl.dart';
import 'package:local_ad_view/src/modules/home/interector/interface/home_service_interface.dart';
import 'package:local_ad_view/src/modules/home/ui/home_page.dart';
import 'interector/home_interector.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.add(HomeInterector.new);
    i.add<HomeServiceInterface>(HomeServiceImpl.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const HomePage());
  }
}
