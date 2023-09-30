import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:local_ad_view/src/modules/home/data/adapters/ad_adapter.dart';

import '../../modules/home/interector/entities/ad_entity.dart';
import 'interface/irepository_firebase.dart';

class RepositoryFirebase implements IRepositoryFirebase {
  final storage = FirebaseStorage.instance;

  @override
  final CollectionReference<AdEntity> ads = FirebaseFirestore.instance
      .collection('/ads/')
      .withConverter<AdEntity>(
        fromFirestore: (snapshots, _) => AdAdpter.fromJson(snapshots.data()!),
        toFirestore: (movie, _) => AdAdpter.toJson(movie),
      );

  @override
  Future<void> addAdImage({required File file, required int screenTime}) async {
    final imagesRef = storage.ref('images');
    await imagesRef.putFile(file);
    ads.add(
      AdEntity(
        creator: '',
        isImage: true,
        hasImageSecondary: false,
        screenTime: screenTime,
        path: await imagesRef.getDownloadURL(),
        imageSecondary: null,
        date: Timestamp.now(),
      ),
    );
  }

  @override
  Future<void> addAdDoubleImage(
      {required File files, required int screenTime}) async {
    ads.add(
      AdEntity(
        creator: '',
        isImage: true,
        hasImageSecondary: true,
        screenTime: screenTime,
        path: '',
        imageSecondary: null,
        date: Timestamp.now(),
      ),
    );
  }

  @override
  Future<void> addAdVideo({required File file, required int screenTime}) async {
    ads.add(
      AdEntity(
        creator: '',
        isImage: false,
        hasImageSecondary: false,
        screenTime: screenTime,
        path: '',
        imageSecondary: null,
        date: Timestamp.now(),
      ),
    );
  }

  @override
  Future cleanFirebase() {
    throw UnimplementedError();
  }
}
