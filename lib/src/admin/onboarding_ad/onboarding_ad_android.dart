import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:local_ad_view/src/admin/onboarding_ad/onboarding_ad_controller.dart';

class OnboardingAdAndroid extends StatefulWidget {
  const OnboardingAdAndroid({super.key});

  @override
  State<OnboardingAdAndroid> createState() => _OnboardingAdAndroidState();
}

class _OnboardingAdAndroidState extends State<OnboardingAdAndroid> {
  final _pageController = PageController();
  final onboardingAdController = OnboardingAdController();
  late final FilePickerResult? files;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Escolha o tipo do anuncio',
                  style: TextStyle(fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    onPressed: () async {
                      files = await FilePicker.platform.pickFiles(
                        type: FileType.image,
                        allowMultiple: false,
                      );
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.elasticOut);
                    },
                    child: const Text('Imagem'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      await FilePicker.platform.pickFiles(
                        type: FileType.image,
                        allowMultiple: true,
                      );
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.elasticOut);
                    },
                    child: const Text('Duas imagens'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    files = await FilePicker.platform.pickFiles(
                      type: FileType.video,
                      allowMultiple: false,
                    );
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.elasticOut);
                  },
                  child: const Text('Video'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.elasticOut),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Text(
                      'Pronto!',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ElevatedButton.icon(
                    label: const Text('Enviar'),
                    onPressed: () {
                      if (files != null) {
                        onboardingAdController.addAdImage(
                          files!,
                        );
                      }
                    },
                    icon: const Icon(Icons.file_upload_outlined),
                  ),
                ),
              ],
            ),
          ),
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
