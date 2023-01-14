import 'package:flutter/material.dart';

import 'login_android.dart';
import 'login_ios.dart';
import 'login_web.dart';

class LoginPage extends StatefulWidget {
  final bool isWeb;
  final bool isAndroid;
  final bool isIos;

  const LoginPage.android({super.key})
      : isAndroid = true,
        isIos = false,
        isWeb = false;

  const LoginPage.ios({super.key})
      : isAndroid = false,
        isIos = true,
        isWeb = false;

  const LoginPage.web({super.key})
      : isAndroid = false,
        isIos = false,
        isWeb = true;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.isWeb) {
      return const LoginWeb();
    } else if (widget.isAndroid) {
      return const LoginAdnroid();
    } else if (widget.isIos) {
      return const LoginIos();
    } else {
      throw Exception('ERROR plataforma não identificada');
    }
  }
}
