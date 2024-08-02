import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/home/interactor/home_interactor.dart';
import 'package:local_ad_view/src/modules/home/interactor/home_state.dart';
import 'package:local_ad_view/src/modules/home/ui/components/ad_widget.dart';
import '../interactor/entities/ad_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeinteractor = Modular.get<Homeinteractor>();

  @override
  void initState() {
    if (!kIsWeb) {
      Modular.to.navigate('/login/login');
    } else {
      homeinteractor.loadAds();
      Timer.periodic(const Duration(minutes: 5),
          (Timer timer) => homeinteractor.loadAds());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: homeinteractor,
      builder: (context, value, child) => switch (value) {
        HomeLoading() => const CircularProgressIndicator(),
        HomeInitial() => const CircularProgressIndicator(),
        HomeFailed() => const Center(child: Text('Erro')),
        HomeSuccess(ads: final List<AdEntity> ads) => AdWidget(ads: ads),
      },
    );
  }
}
