import 'package:local_ad_view/src/modules/dashboard/interector/dashboard_state.dart';

abstract interface class DashboardServiceInterface {
  Future<DashboardState> loadAds();
  Future<DashboardState> removeAd();
}
