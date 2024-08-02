import 'package:cloud_firestore/cloud_firestore.dart';

class AdEntity {
  final bool? hasImageSecondary;
  final String creator, path;
  final String? imageSecondary, id;
  final int screenTime;
  final Timestamp date;

  const AdEntity(
      {this.id,
      required this.creator,
      required this.hasImageSecondary,
      required this.screenTime,
      required this.path,
      required this.imageSecondary,
      required this.date});
}
