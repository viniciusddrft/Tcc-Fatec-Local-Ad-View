import 'package:flutter/material.dart';
import 'package:local_ad_view/src/context/platform_run.dart';

import 'dashboard_ios.dart';
import 'dashboard_web.dart';
import 'dashboard_android.dart';

class DasboardPage extends StatefulWidget {
  const DasboardPage({super.key});

  @override
  State<DasboardPage> createState() => _BasboardPageState();
}

class _BasboardPageState extends State<DasboardPage> {
  @override
  Widget build(BuildContext context) {
    if (PlataformModel.of(context).type == PlatformType.web) {
      return const DashboardWeb();
    } else if (PlataformModel.of(context).type == PlatformType.android) {
      return const DashboardAndroid();
    } else if (PlataformModel.of(context).type == PlatformType.ios) {
      return const DashboardIos();
    } else {
      throw Exception('ERROR plataforma não identificada');
    }
  }
}
