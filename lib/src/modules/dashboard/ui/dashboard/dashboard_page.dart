import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dashboard_mobile.dart';
import 'dashboard_web.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const DashboardWeb();
    } else {
      return const DashboardMobile();
    }
  }
}
