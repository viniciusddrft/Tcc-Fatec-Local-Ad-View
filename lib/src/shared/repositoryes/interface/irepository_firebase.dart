import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/ad_model.dart';

abstract class IRepositoryFirebase {
  abstract final CollectionReference<AdModel> ads;

  Future addAdImage({required File file, required int screenTime});
  Future addAdDoubleImage({required File files, required int screenTime});
  Future addAdVideo({required File file, required int screenTime});

  Future cleanFirebase();
}
