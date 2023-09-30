import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/home/interector/home_interector.dart';
import 'package:local_ad_view/src/modules/home/interector/home_state.dart';
import 'package:local_ad_view/src/modules/home/ui/components/ad_widget.dart';
import '../interector/entities/ad_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeInterector = Modular.get<HomeInterector>();

  @override
  void initState() {
    if (!kIsWeb) {
      Modular.to.navigate('/login/login');
    } else {
      homeInterector.loadAds();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: homeInterector,
      builder: (context, value, child) => switch (value) {
        HomeLoading() => const CircularProgressIndicator(),
        HomeInitial() => const CircularProgressIndicator(),
        HomeFailed() => const Center(
            child: Text('Erro'),
          ),
        HomeSuccess(ads: final List<AdEntity> ads) => AdWidget(
            ads: ads,
          ),
      },
    );
  }
}
