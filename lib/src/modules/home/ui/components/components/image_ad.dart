import 'package:flutter/material.dart';
import '../../../interactor/entities/ad_entity.dart';

class ImageAdWidget extends StatelessWidget {
  const ImageAdWidget({super.key, required this.adEntity});

  final AdEntity adEntity;

  @override
  Widget build(BuildContext context) {
    return Image.network(adEntity.path, fit: BoxFit.contain);
  }
}
