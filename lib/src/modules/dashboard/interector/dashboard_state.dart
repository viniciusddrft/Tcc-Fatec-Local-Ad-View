import 'package:local_ad_view/src/modules/home/interector/entities/ad_entity.dart';

sealed class DashboardState {
  const DashboardState();
}

final class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

final class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

final class DashboardLoadAds extends DashboardState {
  final List<AdEntity> ads;
  const DashboardLoadAds(this.ads);
}

final class DashboardFailed extends DashboardState {
  final String message;
  const DashboardFailed(this.message);
}

final class DashboardRemoveAdSuccess extends DashboardState {
  const DashboardRemoveAdSuccess();
}
