import 'package:local_ad_view/src/modules/home/interactor/home_state.dart';

abstract interface class HomeServiceInterface {
  Future<HomeState> loadAds();
}
