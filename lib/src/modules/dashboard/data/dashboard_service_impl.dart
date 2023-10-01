import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_ad_view/src/modules/dashboard/interector/dashboard_state.dart';
import 'package:local_ad_view/src/modules/dashboard/interector/interface/dashboard_service_interface.dart';
import 'package:local_ad_view/src/modules/home/data/adapters/ad_adapter.dart';
import 'package:local_ad_view/src/modules/home/interector/entities/ad_entity.dart';

class DashboardServiceImpl implements DashboardServiceInterface {
  @override
  Future<DashboardState> loadAds() async {
    try {
      final ads = await FirebaseFirestore.instance.collection('/ads/').get();

      final List<AdEntity> listAds = [];

      for (QueryDocumentSnapshot doc in ads.docs) {
        listAds.add(AdAdpter.fromJson((doc.data() as Map<String, dynamic>)
          ..addAll({'id': doc.reference.id})));
      }

      return DashboardLoadedAds(listAds);
    } catch (e) {
      return DashboardFailed(e.toString());
    }
  }

  @override
  Future<DashboardState> removeAd(String id) async {
    try {
      await FirebaseFirestore.instance.collection('/ads/').doc(id).delete();
      return const DashboardRemoveAdSuccess();
    } catch (e) {
      return DashboardFailed(e.toString());
    }
  }
}
