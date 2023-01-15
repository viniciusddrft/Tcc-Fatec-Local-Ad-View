import 'package:flutter/material.dart';
import 'package:local_ad_view/src/home/home_controller.dart';
import 'package:local_ad_view/src/shared/models/ad_model.dart';

class AdWidget extends StatefulWidget {
  const AdWidget({super.key, required this.homeController});

  final HomeController homeController;

  @override
  State<AdWidget> createState() => _AdWidgetState();
}

class _AdWidgetState extends State<AdWidget> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          for (int i = 0; i != widget.homeController.ads!.length; i++)
            widget.homeController.ads![i].isImage
                ? widget.homeController.ads![i].isImageSmall!
                    ? const Text('Em breve')
                    : ImageAd(
                        adModel: widget.homeController.ads![i],
                        voidCallback: () {
                          if (_pageController.page!.toInt() + 1 !=
                              widget.homeController.ads!.length) {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          } else {
                            _pageController.animateToPage(0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          }
                        },
                      )
                : const Text('Em breve')
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

class ImageAd extends StatelessWidget {
  const ImageAd({super.key, required this.adModel, required this.voidCallback});

  final AdModel adModel;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: adModel.screenTime), (voidCallback));
    return Image.network(adModel.path);
  }
}
