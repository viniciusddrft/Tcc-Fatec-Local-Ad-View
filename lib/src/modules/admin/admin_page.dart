import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_ad_view/src/modules/admin/login/login_android.dart';
import 'package:local_ad_view/src/modules/admin/login/login_ios.dart';
import 'login/login_web.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Center(child: LoginWeb());
    } else if (Platform.isAndroid) {
      return const Center(child: LoginAdnroid());
    } else if (Platform.isIOS) {
      return const Center(child: LoginIos());
    } else {
      throw Exception('ERROR plataforma não identificada');
    }
  }
}
