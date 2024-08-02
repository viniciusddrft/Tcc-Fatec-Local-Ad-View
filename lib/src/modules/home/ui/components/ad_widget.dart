import 'dart:async';
import 'package:flutter/material.dart';
import 'package:local_ad_view/src/modules/home/interactor/entities/ad_entity.dart';
import 'components/image_ad.dart';
import 'components/image_double_ad.dart';

class AdWidget extends StatefulWidget {
  const AdWidget({super.key, required this.ads});

  final List<AdEntity> ads;

  @override
  State<AdWidget> createState() => _AdWidgetState();
}

class _AdWidgetState extends State<AdWidget> {
  final _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(
        Duration(seconds: widget.ads[_currentPage].screenTime), (timer) {
      if (_currentPage < widget.ads.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          for (int i = 0; i != widget.ads.length; i++)
            widget.ads[i].hasImageSecondary!
                ? DoubleImageAdWidget(adEntity: widget.ads[i])
                : ImageAdWidget(adEntity: widget.ads[i])
        ],
        onPageChanged: (int page) {
          setState(() => _currentPage = page);
          _timer?.cancel();
          _startTimer();
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
