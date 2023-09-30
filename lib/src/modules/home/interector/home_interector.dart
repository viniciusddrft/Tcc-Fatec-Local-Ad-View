import 'package:flutter/foundation.dart';
import 'package:local_ad_view/src/modules/home/interector/home_state.dart';
import 'package:local_ad_view/src/modules/home/interector/interface/home_service_interface.dart';

class HomeInterector extends ValueNotifier<HomeState> {
  HomeInterector(this._homeService) : super(const HomeInitial());

  final HomeServiceInterface _homeService;

  void loadAds() async {
    value = const HomeLoading();
    value = await _homeService.loadAds();
  }
}
