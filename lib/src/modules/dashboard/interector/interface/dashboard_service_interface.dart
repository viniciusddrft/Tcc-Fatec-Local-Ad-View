import 'dart:io';
import 'package:local_ad_view/src/modules/dashboard/interector/dashboard_state.dart';
import 'package:local_ad_view/src/modules/home/interector/entities/ad_entity.dart';

abstract interface class DashboardServiceInterface {
  Future<DashboardState> loadAds();
  Future<DashboardState> removeAd(AdEntity ad);
  Future<DashboardState> addAd({required File image, required int screenTime});
  Future<DashboardState> addAdTwoImages(
      {required File image, required File image2, required int screenTime});
}
