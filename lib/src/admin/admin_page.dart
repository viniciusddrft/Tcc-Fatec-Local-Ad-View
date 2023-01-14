import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'login/login_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Center(
        child: LoginPage.web(),
      );
    } else if (Platform.isAndroid) {
      return const Center(
        child: LoginPage.android(),
      );
    } else if (Platform.isIOS) {
      return const Center(
        child: LoginPage.ios(),
      );
    } else {
      throw Exception('ERROR plataforma não identificada');
    }
  }
}
