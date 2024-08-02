import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_ad_view/src/modules/login/ui/register/register_mobile.dart';
import 'package:local_ad_view/src/modules/login/ui/register/register_web.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const RegisterWeb();
    } else {
      return const RegisterMobile();
    }
  }
}
