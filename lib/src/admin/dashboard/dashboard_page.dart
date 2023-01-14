import 'package:flutter/material.dart';

import 'dashboard_ios.dart';
import 'dashboard_web.dart';
import 'dashboard_android.dart';

class DasboardPage extends StatefulWidget {
  final bool isWeb;
  final bool isAndroid;
  final bool isIos;

  const DasboardPage.android({super.key})
      : isAndroid = true,
        isIos = false,
        isWeb = false;

  const DasboardPage.ios({super.key})
      : isAndroid = false,
        isIos = true,
        isWeb = false;

  const DasboardPage.web({super.key})
      : isAndroid = false,
        isIos = false,
        isWeb = true;

  @override
  State<DasboardPage> createState() => _BasboardPageState();
}

class _BasboardPageState extends State<DasboardPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.isWeb) {
      return const DashboardWeb();
    } else if (widget.isAndroid) {
      return const DashboardAndroid();
    } else if (widget.isIos) {
      return const DashboardIos();
    } else {
      throw Exception('ERROR plataforma não identificada');
    }
  }
}
