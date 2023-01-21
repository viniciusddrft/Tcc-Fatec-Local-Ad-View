import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DashboardWeb extends StatefulWidget {
  const DashboardWeb({super.key});

  @override
  State<DashboardWeb> createState() => _DashboardWebState();
}

class _DashboardWebState extends State<DashboardWeb> {
  final PageController _pageController = PageController();
  final ValueNotifier<bool> _isImage = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('dashboard'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: ValueListenableBuilder(
          valueListenable: _isImage,
          builder: (BuildContext context, value, Widget? child) => PageView(
            controller: _pageController,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        _isImage.value = true;
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.decelerate);
                      },
                      child: const Text('Image'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _isImage.value = false;
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.decelerate);
                    },
                    child: const Text('Video'),
                  )
                ],
              ),
              _isImage.value
                  ? const Text('Subir image')
                  : const Text('Subir video')
            ],
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: 80,
        child: Center(
          child: SmoothPageIndicator(
            onDotClicked: null,
            controller: _pageController,
            count: 2,
            effect: const WormEffect(
              activeDotColor: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _isImage.dispose();
    super.dispose();
  }
}
