import 'package:flutter/material.dart';

import '../../../interector/entities/ad_entity.dart';

class ImageAdWidget extends StatelessWidget {
  const ImageAdWidget(
      {super.key, required this.adEntity, required this.voidCallback});

  final AdEntity adEntity;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: adEntity.screenTime), (voidCallback));
    return Image.network(adEntity.path, fit: BoxFit.fill);
  }
}
