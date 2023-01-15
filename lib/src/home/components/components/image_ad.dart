import 'package:flutter/material.dart';

import '../../../shared/models/ad_model.dart';

class ImageAdWidget extends StatelessWidget {
  const ImageAdWidget(
      {super.key, required this.adModel, required this.voidCallback});

  final AdModel adModel;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: adModel.screenTime), (voidCallback));
    return Image.network(adModel.path);
  }
}
