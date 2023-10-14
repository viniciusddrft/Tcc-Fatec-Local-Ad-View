import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_ad_view/src/modules/dashboard/ui/onboarding/onboarding_add_ad_android.dart';
import 'package:local_ad_view/src/modules/dashboard/ui/onboarding/onboarding_add_ad_web.dart';
import 'onboarding_add_ad_ios.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const OnboardingAddAdWeb();
    } else if (Platform.isAndroid) {
      return const OnboardingAddAdAndroid();
    } else if (Platform.isIOS) {
      return const OnboardingAddAdIos();
    } else {
      throw Exception('ERROR plataforma não identificada');
    }
  }
}
