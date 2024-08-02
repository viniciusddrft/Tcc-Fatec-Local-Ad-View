import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../interactor/dashboard_interactor.dart';
import '../../interactor/dashboard_state.dart';

class OnboardingAddAdWeb extends StatefulWidget {
  const OnboardingAddAdWeb({super.key});

  @override
  State<OnboardingAddAdWeb> createState() => _OnboardingAddAdWebState();
}

class _OnboardingAddAdWebState extends State<OnboardingAddAdWeb> {
  final image = ValueNotifier<File?>(null);
  final image2 = ValueNotifier<File?>(null);
  final hasTwoImages = ValueNotifier<bool>(false);
  final dashboardinteractor = Modular.get<DashboardInteractor>();
  final secondsController = TextEditingController();
  final secondsFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    dashboardinteractor.addListener(() {
      if (dashboardinteractor.value is DashboardAddNewAd) {
        showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: Text('Anúncio adicionado com successo!'),
                ),
              );
            },
            backgroundColor: Colors.grey);

        Future.delayed(const Duration(seconds: 1),
            () => Modular.to.navigate('/dashboard/dashboard'));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    hasTwoImages.dispose();
    image.dispose();
    image2.dispose();
    dashboardinteractor.dispose();
    secondsController.dispose();
    secondsFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Anúncio'),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge(
            [hasTwoImages, image, image2, dashboardinteractor]),
        builder: (context, child) {
          if (dashboardinteractor.value is DashboardLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (dashboardinteractor.value is DashboardFailed) {
            return Center(
              child:
                  Text((dashboardinteractor.value as DashboardFailed).message),
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50.0,
                        width: 150.0,
                        child: RadioMenuButton<bool>(
                          value: false,
                          groupValue: hasTwoImages.value,
                          onChanged: (value) => hasTwoImages.value = false,
                          child: const Text('1 Imagem'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: SizedBox(
                          height: 50.0,
                          width: 150.0,
                          child: RadioMenuButton<bool>(
                            value: true,
                            groupValue: hasTwoImages.value,
                            onChanged: (value) => hasTwoImages.value = true,
                            child: const Text('2 Imagens'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: GestureDetector(
                        onTap: () async {
                          final FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.image,
                          );

                          final platformFile = result!.files.first;

                          image.value = File.fromRawPath(platformFile.bytes!);
                        },
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Deseja remover a imagem?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Modular.to.pop(),
                                  child: const Text(
                                    'Cancelar',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    image.value = null;
                                    Modular.to.pop();
                                  },
                                  child: const Text('Remover Imagem'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 250,
                          height: 150,
                          child: Card(
                            color: image.value == null
                                ? Colors.white70
                                : Colors.greenAccent,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: image.value == null
                                    ? [
                                        const Icon(Icons.upload_rounded),
                                        const Text('Adiciona uma imagem.')
                                      ]
                                    : [
                                        const Icon(Icons.done),
                                        const Text('Imagem Adicionado!')
                                      ]),
                          ),
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      switchInCurve: Curves.decelerate,
                      switchOutCurve: Curves.decelerate,
                      duration: const Duration(milliseconds: 700),
                      child: hasTwoImages.value
                          ? Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: GestureDetector(
                                onTap: () async {
                                  final FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                          type: FileType.image,
                                          allowedExtensions: [
                                        'jpeg',
                                        'png',
                                        'jpg'
                                      ]);

                                  final platformFile = result!.files.first;
                                  image2.value =
                                      File.fromRawPath(platformFile.bytes!);
                                },
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(
                                          'Deseja remover a imagem?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Modular.to.pop(),
                                          child: const Text(
                                            'Cancelar',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            image2.value = null;
                                            Modular.to.pop();
                                          },
                                          child: const Text('Remover Imagem'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: 250,
                                  height: 150,
                                  child: Card(
                                    color: image2.value == null
                                        ? Colors.white70
                                        : Colors.greenAccent,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: image2.value == null
                                            ? [
                                                const Icon(
                                                    Icons.upload_rounded),
                                                const Text(
                                                    'Adiciona uma imagem.')
                                              ]
                                            : [
                                                const Icon(Icons.done),
                                                const Text('Imagem Adicionado!')
                                              ]),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text('Coloque o tempo de duração em segundos'),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: SizedBox(
                    width: 300,
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: secondsController,
                        focusNode: secondsFocus,
                        decoration: const InputDecoration(
                          labelText: 'Duração ...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      secondsFocus.unfocus();

                      if (_formKey.currentState!.validate()) {
                        if (hasTwoImages.value) {
                          dashboardinteractor.addAD(
                              image: image.value!,
                              image2: image2.value!,
                              seconds: int.parse(secondsController.text));
                        } else {
                          dashboardinteractor.addAD(
                              image: image.value!,
                              seconds: int.parse(secondsController.text));
                        }
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Adiconar anuncio'),
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
