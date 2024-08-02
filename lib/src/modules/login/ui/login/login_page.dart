import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'login_mobile.dart';
import 'login_web.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const LoginWeb();
    } else {
      return const LoginMobile();
    }
  }
}
