import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/ad_model.dart';

class RepositoryFirebase {
  final CollectionReference<AdModel> ads = FirebaseFirestore.instance
      .collection('/ads/')
      .withConverter<AdModel>(
        fromFirestore: (snapshots, _) => AdModel.fromJson(snapshots.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );
}
