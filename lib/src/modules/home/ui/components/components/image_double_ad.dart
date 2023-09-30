import 'package:flutter/material.dart';

import '../../../interector/entities/ad_entity.dart';

class DoubleImageAdWidget extends StatelessWidget {
  const DoubleImageAdWidget(
      {super.key, required this.adEntity, required this.voidCallback});

  final AdEntity adEntity;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: adEntity.screenTime), (voidCallback));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Image.network(adEntity.path, fit: BoxFit.contain)),
        Expanded(
            child: Image.network(adEntity.imageSecondary!, fit: BoxFit.contain))
      ],
    );
  }
}
