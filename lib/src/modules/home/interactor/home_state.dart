import 'package:local_ad_view/src/modules/home/interactor/entities/ad_entity.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeSuccess extends HomeState {
  final List<AdEntity> ads;

  const HomeSuccess(this.ads);
}

final class HomeFailed extends HomeState {
  const HomeFailed();
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}
