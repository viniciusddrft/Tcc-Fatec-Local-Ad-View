import 'package:local_ad_view/src/modules/login/interactor/entities/user.dart';

class UserAdapter {
  static UserEntity fromJson(Map<String, dynamic> json) => UserEntity(
        user: json['user'],
        isAdm: json['isAdm'],
      );

  static Map<String, dynamic> toJson(UserEntity user) => {
        'user': user.user,
        'isAdm': user.isAdm,
      };
}
