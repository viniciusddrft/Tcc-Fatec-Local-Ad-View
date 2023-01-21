import 'package:flutter/material.dart';
import 'package:local_ad_view/src/admin/login/login_android.dart';
import 'package:local_ad_view/src/admin/login/login_ios.dart';

import '../context/platform_run.dart';
import 'login/login_web.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (PlataformModel.of(context).type == PlatformType.web) {
      return const Center(child: LoginWeb());
    } else if (PlataformModel.of(context).type == PlatformType.android) {
      return const Center(child: LoginAdnroid());
    } else if (PlataformModel.of(context).type == PlatformType.ios) {
      return const Center(child: LoginIos());
    } else {
      throw Exception('ERROR plataforma não identificada');
    }
  }
}
