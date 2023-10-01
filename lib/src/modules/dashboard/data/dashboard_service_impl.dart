import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/dashboard/interector/dashboard_state.dart';
import 'package:local_ad_view/src/modules/dashboard/interector/interface/dashboard_service_interface.dart';
import 'package:local_ad_view/src/modules/home/data/adapters/ad_adapter.dart';
import 'package:local_ad_view/src/modules/home/interector/entities/ad_entity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:local_ad_view/src/modules/login/interector/login_interector.dart';
import 'package:local_ad_view/src/modules/login/interector/login_state.dart';

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

      final String name = (Modular.get<LoginInteretor>().value as LoggedSuccess)
          .user
          .displayName!;

      final ad = AdEntity(
          creator: name,
          isImage: true,
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
      final UploadTask uploadTask = storageReference.putFile(image);
      final TaskSnapshot downloadUrl = (await uploadTask);
      final String url = await downloadUrl.ref.getDownloadURL();
      final UploadTask uploadTask2 = storageReference.putFile(image2);
      final TaskSnapshot downloadUrl2 = (await uploadTask2);
      final String url2 = await downloadUrl2.ref.getDownloadURL();

      final String name = (Modular.get<LoginInteretor>().value as LoggedSuccess)
          .user
          .displayName!;

      final ad = AdEntity(
          creator: name,
          isImage: true,
          hasImageSecondary: true,
          screenTime: screenTime,
          path: url,
          imageSecondary: url2,
          date: Timestamp.now());

      await FirebaseFirestore.instance
          .collection('/ads/')
          .add(AdAdpter.toJson(ad));
      return const DashboardAddNewAd();
    } catch (e) {
      return DashboardFailed(e.toString());
    }
  }
}
