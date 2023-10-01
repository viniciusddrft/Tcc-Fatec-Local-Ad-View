import 'dart:io';
import 'package:local_ad_view/src/modules/dashboard/interector/dashboard_state.dart';

abstract interface class DashboardServiceInterface {
  Future<DashboardState> loadAds();
  Future<DashboardState> removeAd(String id);
  Future<DashboardState> addAd({required File image, required int screenTime});
  Future<DashboardState> addAdTwoImages(
      {required File image, required File image2, required int screenTime});
}
