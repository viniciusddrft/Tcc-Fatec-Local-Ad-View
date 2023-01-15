import 'package:cloud_firestore/cloud_firestore.dart';

class AdModel {
  final bool isImage;
  final bool? hasImageSecondary;
  final String creator, path;
  final String? imageSecondary;
  final int screenTime;
  final Timestamp date;

  bool get isVideo => !isImage;

  const AdModel(
      {required this.creator,
      required this.isImage,
      required this.hasImageSecondary,
      required this.screenTime,
      required this.path,
      required this.imageSecondary,
      required this.date});

  factory AdModel.fromJson(Map<String, dynamic> json) => AdModel(
      creator: json['creator'],
      isImage: json['isImage'],
      hasImageSecondary: json['hasImageSecondary'],
      imageSecondary: json['imageSecondary'],
      path: json['path'],
      date: json['date'],
      screenTime: json['screenTime']);

  Map<String, dynamic> toJson() => {
        'creator': creator,
        'isImage': isImage,
        'hasImageSecondary': hasImageSecondary,
        'path': path,
        'screenTime': screenTime,
        'imageSecondary': imageSecondary
      };
}
