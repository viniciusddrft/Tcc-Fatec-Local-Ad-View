import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_ad_view/src/modules/dashboard/ui/onboarding/onboarding_add_ad_mobile.dart';
import 'package:local_ad_view/src/modules/dashboard/ui/onboarding/onboarding_add_ad_web.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const OnboardingAddAdWeb();
    } else {
      return const OnboardingAddAdMobile();
    }
  }
}
