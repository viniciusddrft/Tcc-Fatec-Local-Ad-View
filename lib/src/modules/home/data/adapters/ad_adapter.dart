import '../../interector/entities/ad_entity.dart';

class AdAdpter {
  static AdEntity fromJson(Map<String, dynamic> json) => AdEntity(
      id: json['id'],
      creator: json['creator'],
      isImage: json['isImage'],
      hasImageSecondary: json['hasImageSecondary'],
      imageSecondary: json['imageSecondary'],
      path: json['path'],
      date: json['date'],
      screenTime: json['screenTime']);

  static Map<String, dynamic> toJson(AdEntity ad) => {
        'id': ad.id,
        'creator': ad.creator,
        'isImage': ad.isImage,
        'hasImageSecondary': ad.hasImageSecondary,
        'path': ad.path,
        'screenTime': ad.screenTime,
        'imageSecondary': ad.imageSecondary
      };
}
