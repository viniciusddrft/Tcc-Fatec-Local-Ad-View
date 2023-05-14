import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/ad_model.dart';

abstract interface class IRepositoryFirebase {
  abstract final CollectionReference<AdModel> ads;

  Future<void> addAdImage({required File file, required int screenTime});
  Future<void> addAdDoubleImage({required File files, required int screenTime});
  Future<void> addAdVideo({required File file, required int screenTime});
  Future<void> cleanFirebase();
}
