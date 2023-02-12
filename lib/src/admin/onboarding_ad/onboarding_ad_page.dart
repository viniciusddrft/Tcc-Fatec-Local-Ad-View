import 'package:flutter/material.dart';
import 'package:local_ad_view/src/admin/onboarding_ad/onboarding_ad_android.dart';
import 'package:local_ad_view/src/admin/onboarding_ad/onboarding_ad_ios.dart';
import 'package:local_ad_view/src/admin/onboarding_ad/onboarding_ad_web.dart';

import '../../context/platform_run.dart';

class OnboardingAdPage extends StatelessWidget {
  const OnboardingAdPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (PlataformModel.of(context).type == PlatformType.web) {
      return const OnboardingAdWeb();
    } else if (PlataformModel.of(context).type == PlatformType.android) {
      return const OnboardingAdAndroid();
    } else if (PlataformModel.of(context).type == PlatformType.ios) {
      return const OnboardingAdIos();
    } else {
      throw Exception('ERROR plataforma não identificada');
    }
  }
}
