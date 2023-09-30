import 'package:flutter/material.dart';

import '../../../shared/models/ad_model.dart';

class DoubleImageAdWidget extends StatelessWidget {
  const DoubleImageAdWidget(
      {super.key, required this.adModel, required this.voidCallback});

  final AdModel adModel;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: adModel.screenTime), (voidCallback));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Image.network(adModel.path, fit: BoxFit.contain)),
        Expanded(
            child: Image.network(adModel.imageSecondary!, fit: BoxFit.contain))
      ],
    );
  }
}
