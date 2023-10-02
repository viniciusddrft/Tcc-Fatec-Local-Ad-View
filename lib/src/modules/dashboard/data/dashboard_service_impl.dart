import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_ad_view/src/modules/dashboard/interector/dashboard_state.dart';
import 'package:local_ad_view/src/modules/dashboard/interector/interface/dashboard_service_interface.dart';
import 'package:local_ad_view/src/modules/home/data/adapters/ad_adapter.dart';
import 'package:local_ad_view/src/modules/home/interector/entities/ad_entity.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  Future<DashboardState> removeAd(AdEntity ad) async {
    try {
      final Reference referenceImage =
          FirebaseStorage.instance.refFromURL(ad.path);
      await referenceImage.delete();
      if (ad.hasImageSecondary!) {
        final Reference referenceImage2 =
            FirebaseStorage.instance.refFromURL(ad.imageSecondary!);
        await referenceImage2.delete();
      }
      await FirebaseFirestore.instance.collection('/ads/').doc(ad.id).delete();
      return const DashboardRemoveAdSuccess();
    } catch (e) {
      return DashboardFailed(e.toString());
    }
  }

  @override
  Future<DashboardState> addAd(
      {required File image, required int screenTime}) async {
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('ads${DateTime.now().millisecondsSinceEpoch}');
      final UploadTask uploadTask = storageReference.putFile(image);
      final TaskSnapshot downloadUrl = (await uploadTask);
      final String url = await downloadUrl.ref.getDownloadURL();

      final ad = AdEntity(
          creator: FirebaseAuth.instance.currentUser!.email!,
          hasImageSecondary: false,
          screenTime: screenTime,
          path: url,
          imageSecondary: null,
          date: Timestamp.now());

      await FirebaseFirestore.instance
          .collection('/ads/')
          .add(AdAdpter.toJson(ad));
      return const DashboardAddNewAd();
    } catch (e) {
      return DashboardFailed(e.toString());
    }
  }

  @override
  Future<DashboardState> addAdTwoImages(
      {required File image,
      required File image2,
      required int screenTime}) async {
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('ads${DateTime.now().millisecondsSinceEpoch}');
      final Reference storageReference2 = FirebaseStorage.instance
          .ref()
          .child('ads2${DateTime.now().millisecondsSinceEpoch}');
      final UploadTask uploadTask = storageReference.putFile(image);
      final TaskSnapshot downloadUrl = (await uploadTask);
      final String url = await downloadUrl.ref.getDownloadURL();
      final UploadTask uploadTask2 = storageReference2.putFile(image2);
      final TaskSnapshot downloadUrl2 = (await uploadTask2);
      final String url2 = await downloadUrl2.ref.getDownloadURL();

      final ad = AdEntity(
        creator: FirebaseAuth.instance.currentUser!.email!,
        hasImageSecondary: true,
        screenTime: screenTime,
        path: url,
        imageSecondary: url2,
        date: Timestamp.now(),
      );

      await FirebaseFirestore.instance
          .collection('/ads/')
          .add(AdAdpter.toJson(ad));
      return const DashboardAddNewAd();
    } catch (e) {
      return DashboardFailed(e.toString());
    }
  }
}
