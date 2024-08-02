import 'package:flutter/material.dart';

import '../../../interactor/entities/ad_entity.dart';

class DoubleImageAdWidget extends StatelessWidget {
  const DoubleImageAdWidget({super.key, required this.adEntity});

  final AdEntity adEntity;

  @override
  Widget build(BuildContext context) {
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
