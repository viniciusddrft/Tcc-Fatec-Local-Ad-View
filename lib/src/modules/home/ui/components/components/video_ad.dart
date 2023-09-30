import 'package:flutter/material.dart';

import '../../../interector/entities/ad_entity.dart';

class VideoAdWidget extends StatelessWidget {
  const VideoAdWidget(
      {super.key, required this.adEntity, required this.voidCallback});

  final AdEntity adEntity;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: adEntity.screenTime), (voidCallback));
    return const Text('Em breve');
  }
}
