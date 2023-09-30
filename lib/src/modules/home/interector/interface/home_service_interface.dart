import 'package:local_ad_view/src/modules/home/interector/home_state.dart';

abstract interface class HomeServiceInterface {
  Future<HomeState> loadAds();
}
