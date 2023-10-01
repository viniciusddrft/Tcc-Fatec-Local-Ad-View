import 'dart:io';
import 'package:flutter/material.dart';
import 'package:local_ad_view/src/modules/dashboard/interector/dashboard_state.dart';
import 'package:local_ad_view/src/modules/dashboard/interector/interface/dashboard_service_interface.dart';

class DashboardInterector extends ValueNotifier<DashboardState> {
  DashboardInterector(this.dashboardService) : super(const DashboardInitial());

  final DashboardServiceInterface dashboardService;

  void loadAds() async {
    value = const DashboardLoading();
    value = await dashboardService.loadAds();
  }

  void removeAd(String id) async {
    value = const DashboardLoading();
    value = await dashboardService.removeAd(id);
  }

  void addAD({required File image, File? image2, required int seconds}) async {
    value = const DashboardLoading();

    if (image2 == null) {
      value = await dashboardService.addAd(image: image, screenTime: seconds);
    } else {
      value = await dashboardService.addAdTwoImages(
          image: image, image2: image2, screenTime: seconds);
    }
  }
}
