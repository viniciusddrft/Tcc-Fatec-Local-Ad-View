import 'package:flutter/material.dart';

import '../admin/admin_page.dart';
import '../admin/dashboard/dashboard_page.dart';
import '../home/home_page.dart';

class Routes {
  static Route<dynamic>? manageRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home':
        return MaterialPageRoute(
          builder: (BuildContext context) => const MyHomePage(),
        );

      case '/adminLocalAdView':
        return MaterialPageRoute(
          builder: (BuildContext context) => const AdminPage(),
        );
      case '/dashboard':
        final arguments = routeSettings.arguments as Map<String, bool>;

        if (arguments['isWeb'] == true) {
          return MaterialPageRoute(
            builder: (BuildContext context) => const DasboardPage.web(),
          );
        } else if (arguments['isAndroid'] == true) {
          return MaterialPageRoute(
            builder: (BuildContext context) => const DasboardPage.android(),
          );
        } else if (arguments['isIos'] == true) {
          return MaterialPageRoute(
            builder: (BuildContext context) => const DasboardPage.ios(),
          );
        } else {
          throw Exception(['Argumentos inválidos']);
        }

      default:
        return null;
    }
  }
}
