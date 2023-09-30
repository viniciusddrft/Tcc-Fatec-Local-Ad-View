import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_ad_view/src/shared/repositoryes/repository_firebase.dart';

import '../shared/models/ad_model.dart';

class HomeController {
  List<AdModel>? ads;
  final _repositoryFirebase = RepositoryFirebase();

  Stream<QuerySnapshot<AdModel>> get adsSnapshot =>
      _repositoryFirebase.ads.snapshots();
}
