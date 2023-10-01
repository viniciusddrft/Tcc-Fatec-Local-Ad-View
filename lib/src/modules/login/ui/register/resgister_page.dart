import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_ad_view/src/modules/login/ui/register/register_android.dart';
import 'package:local_ad_view/src/modules/login/ui/register/register_ios.dart';
import 'package:local_ad_view/src/modules/login/ui/register/register_web.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const RegisterWeb();
    } else if (Platform.isAndroid) {
      return const RegisterAndroid();
    } else if (Platform.isIOS) {
      return const RegisterIos();
    } else {
      throw Exception('ERROR plataforma não identificada');
    }
  }
}
