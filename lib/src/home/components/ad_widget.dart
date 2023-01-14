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
  void initState() {
    _pageController.addListener(() {
      for (int i = 0; i > widget.homeController.ads!.length; i++) {
        Future.delayed(
            Duration(seconds: widget.homeController.ads![i].screenTime), () {
          if (widget.homeController.ads!.length > 1) {
            if (i < widget.homeController.ads!.length) {
              _pageController.animateToPage(++i,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubicEmphasized);
            } else {
              _pageController.animateToPage(0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubicEmphasized);
            }
          }
        });
      }
    });
    super.initState();
  }

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
  const ImageAd({super.key, required this.adModel});

  final AdModel adModel;

  @override
  Widget build(BuildContext context) {
    return Image.network(adModel.path);
  }
}
