import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_ad_view/src/modules/home/data/adapters/ad_adapter.dart';
import 'package:local_ad_view/src/modules/home/interector/entities/ad_entity.dart';
import 'package:local_ad_view/src/modules/home/interector/home_state.dart';
import 'package:local_ad_view/src/modules/home/interector/interface/home_service_interface.dart';

class HomeServiceImpl implements HomeServiceInterface {
  @override
  Future<HomeState> loadAds() async {
    try {
      final ads = await FirebaseFirestore.instance.collection('/ads/').get();

      final List<AdEntity> listAds = [];

      for (QueryDocumentSnapshot doc in ads.docs) {
        listAds.add(AdAdpter.fromJson(doc.data() as Map<String, dynamic>));
      }

      return HomeSuccess(listAds);
    } catch (e) {
      return const HomeFailed();
    }
  }
}
