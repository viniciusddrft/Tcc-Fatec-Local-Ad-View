import 'package:local_ad_view/src/modules/home/interactor/entities/ad_entity.dart';

sealed class DashboardState {
  const DashboardState();
}

final class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

final class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

final class DashboardAddNewAd extends DashboardState {
  const DashboardAddNewAd();
}

final class DashboardLoadedAds extends DashboardState {
  final List<AdEntity> ads;
  const DashboardLoadedAds(this.ads);
}

final class DashboardFailed extends DashboardState {
  final String message;
  const DashboardFailed(this.message);
}

final class DashboardRemoveAdSuccess extends DashboardState {
  const DashboardRemoveAdSuccess();
}
