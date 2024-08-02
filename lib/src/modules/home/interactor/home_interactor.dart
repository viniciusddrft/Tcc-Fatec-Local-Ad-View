import 'package:flutter/foundation.dart';
import 'package:local_ad_view/src/modules/home/interactor/home_state.dart';
import 'package:local_ad_view/src/modules/home/interactor/interface/home_service_interface.dart';

class Homeinteractor extends ValueNotifier<HomeState> {
  Homeinteractor(this._homeService) : super(const HomeInitial());

  final HomeServiceInterface _homeService;

  void loadAds() async {
    value = const HomeLoading();
    value = await _homeService.loadAds();
  }
}
