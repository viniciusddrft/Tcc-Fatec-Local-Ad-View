import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../modules/home/interector/entities/ad_entity.dart';

abstract interface class IRepositoryFirebase {
  abstract final CollectionReference<AdEntity> ads;

  Future<void> addAdImage({required File file, required int screenTime});
  Future<void> addAdDoubleImage({required File files, required int screenTime});
  Future<void> addAdVideo({required File file, required int screenTime});
  Future<void> cleanFirebase();
}
