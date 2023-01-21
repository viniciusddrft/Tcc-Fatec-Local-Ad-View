import 'package:flutter/widgets.dart';

enum PlatformType { android, ios, web }

class PlataformModel extends InheritedModel<PlatformType> {
  const PlataformModel({super.key, required super.child, required this.type});

  final PlatformType type;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  @override
  bool updateShouldNotifyDependent(
          covariant InheritedModel oldWidget, Set dependencies) =>
      false;

  static PlataformModel of(BuildContext context) =>
      InheritedModel.inheritFrom<PlataformModel>(context)!;
}
