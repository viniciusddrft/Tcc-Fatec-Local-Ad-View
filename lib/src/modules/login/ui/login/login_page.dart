import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'login_android.dart';
import 'login_ios.dart';
import 'login_web.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
