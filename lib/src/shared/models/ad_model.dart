import 'package:cloud_firestore/cloud_firestore.dart';

class AdModel {
  final bool isImage, isVideo;
  final bool? isImageSmall;
  final String creator, path;
  final int screenTime;
  final Timestamp date;

  AdModel(
      {required this.creator,
      required this.isImage,
      required this.isImageSmall,
      required this.isVideo,
      required this.screenTime,
      required this.path,
      required this.date})
      : assert(isImage != isVideo);

  factory AdModel.fromJson(Map<String, dynamic> json) => AdModel(
      creator: json['creator'],
      isImage: json['isImage'],
      isImageSmall: json['isImageSmall'],
      isVideo: json['isVideo'],
      path: json['path'],
      date: json['date'],
      screenTime: json['screenTime']);

  Map<String, dynamic> toJson() => {
        'creator': creator,
        'isImage': isImage,
        'isImageSmall': isImageSmall,
        'isVideo': isVideo,
        'path': path,
        'screenTime': screenTime,
      };
}
