import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dashboard_ios.dart';
import 'dashboard_web.dart';
import 'dashboard_android.dart';

class DasboardPage extends StatelessWidget {
  const DasboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const DashboardWeb();
    } else if (Platform.isAndroid) {
      return const DashboardAndroid();
    } else if (Platform.isIOS) {
      return const DashboardIos();
    } else {
      throw Exception('ERROR plataforma não identificada');
    }
  }
}
