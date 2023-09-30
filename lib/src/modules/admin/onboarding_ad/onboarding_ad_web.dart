import 'package:flutter/material.dart';

class OnboardingAdWeb extends StatefulWidget {
  const OnboardingAdWeb({super.key});

  @override
  State<OnboardingAdWeb> createState() => _OnboardingAdWebState();
}

class _OnboardingAdWebState extends State<OnboardingAdWeb> {
  final PageController _pageController = PageController();

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Escolha o tipo do anuncio',
                  style: TextStyle(fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                      onPressed: () => _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.elasticOut),
                      child: const Text('Imagem')),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                      onPressed: () => _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.elasticOut),
                      child: const Text('Duas imagens')),
                ),
                ElevatedButton(
                    onPressed: () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.elasticOut),
                    child: const Text('Video')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => _pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.elasticOut),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Text(
                      'Selecione o arquivo',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ElevatedButton.icon(
                    label: const Text('pegar da galeria'),
                    onPressed: () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.elasticOut),
                    icon: const Icon(Icons.file_upload_outlined),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    onPressed: () {},
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
