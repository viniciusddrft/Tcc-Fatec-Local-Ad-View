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
        return MaterialPageRoute(
          builder: (BuildContext context) => const DasboardPage(),
        );

      default:
        return null;
    }
  }
}
