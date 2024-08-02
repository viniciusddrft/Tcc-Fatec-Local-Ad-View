import '../../interactor/entities/ad_entity.dart';

class AdAdpter {
  static AdEntity fromJson(Map<String, dynamic> json) => AdEntity(
      id: json['id'],
      creator: json['creator'],
      hasImageSecondary: json['hasImageSecondary'],
      imageSecondary: json['imageSecondary'],
      path: json['path'],
      date: json['date'],
      screenTime: json['screenTime']);

  static Map<String, dynamic> toJson(AdEntity ad) => {
        'creator': ad.creator,
        'hasImageSecondary': ad.hasImageSecondary,
        'path': ad.path,
        'screenTime': ad.screenTime,
        'imageSecondary': ad.imageSecondary,
        'date': ad.date,
      };
}
