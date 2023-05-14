import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/ad_model.dart';
import 'interface/irepository_firebase.dart';

class RepositoryFirebase implements IRepositoryFirebase {
  final storage = FirebaseStorage.instance;

  @override
  final CollectionReference<AdModel> ads = FirebaseFirestore.instance
      .collection('/ads/')
      .withConverter<AdModel>(
        fromFirestore: (snapshots, _) => AdModel.fromJson(snapshots.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  @override
  Future<void> addAdImage({required File file, required int screenTime}) async {
    final imagesRef = storage.ref('images');
    await imagesRef.putFile(file);
    ads.add(
      AdModel(
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
      AdModel(
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
      AdModel(
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
