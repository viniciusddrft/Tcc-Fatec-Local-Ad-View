import 'package:flutter/material.dart';
import 'package:local_ad_view/src/modules/home/interector/entities/ad_entity.dart';
import 'components/image_ad.dart';
import 'components/image_double_ad.dart';
import 'components/video_ad.dart';

class AdWidget extends StatefulWidget {
  const AdWidget({super.key, required this.ads});

  final List<AdEntity> ads;

  @override
  State<AdWidget> createState() => _AdWidgetState();
}

class _AdWidgetState extends State<AdWidget> {
  final _pageController = PageController();

  void _loop() {
    if (_pageController.page!.toInt() + 1 != widget.ads.length) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate);
    } else {
      _pageController.animateToPage(0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          for (int i = 0; i != widget.ads.length; i++)
            widget.ads[i].isImage
                ? widget.ads[i].hasImageSecondary!
                    ? DoubleImageAdWidget(
                        adEntity: widget.ads[i],
                        voidCallback: _loop,
                      )
                    : ImageAdWidget(
                        adEntity: widget.ads[i],
                        voidCallback: _loop,
                      )
                : VideoAdWidget(
                    adEntity: widget.ads[i],
                    voidCallback: _loop,
                  )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
