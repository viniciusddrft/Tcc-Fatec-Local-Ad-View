import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_ad_view/src/modules/admin/onboarding_ad/onboarding_ad_android.dart';
import 'package:local_ad_view/src/modules/admin/onboarding_ad/onboarding_ad_ios.dart';
import 'package:local_ad_view/src/modules/admin/onboarding_ad/onboarding_ad_web.dart';

class OnboardingAdPage extends StatelessWidget {
  const OnboardingAdPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const OnboardingAdWeb();
    } else if (Platform.isAndroid) {
      return const OnboardingAdAndroid();
    } else if (Platform.isIOS) {
      return const OnboardingAdIos();
    } else {
      throw Exception('ERROR plataforma não identificada');
    }
  }
}
