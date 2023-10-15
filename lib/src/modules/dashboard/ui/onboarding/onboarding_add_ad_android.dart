import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/dashboard/interector/dashboard_interector.dart';
import 'package:local_ad_view/src/modules/dashboard/interector/dashboard_state.dart';
import 'package:local_ad_view/src/modules/login/interector/login_interector.dart';

class OnboardingAddAdAndroid extends StatefulWidget {
  const OnboardingAddAdAndroid({super.key});

  @override
  State<OnboardingAddAdAndroid> createState() => _OnboardingAddAdAndroidState();
}

class _OnboardingAddAdAndroidState extends State<OnboardingAddAdAndroid> {
  final image = ValueNotifier<File?>(null);
  final image2 = ValueNotifier<File?>(null);
  final hasTwoImages = ValueNotifier<bool>(false);
  final dashboardInterector = Modular.get<DashboardInterector>();
  final loginInterector = Modular.get<LoginInterector>();
  final secondsController = TextEditingController();
  final secondsFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    dashboardInterector.addListener(() {
      if (dashboardInterector.value is DashboardAddNewAd) {
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

        Future.delayed(
          const Duration(seconds: 1),
          () => Modular.to.pushReplacementNamed('/dashboard/dashboard'),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    hasTwoImages.dispose();
    image.dispose();
    image2.dispose();
    dashboardInterector.dispose();
    secondsController.dispose();
    secondsFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Anúncio'),
        automaticallyImplyLeading: false,
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge(
            [hasTwoImages, image, image2, dashboardInterector]),
        builder: (context, child) {
          if (dashboardInterector.value is DashboardLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (dashboardInterector.value is DashboardFailed) {
            return Center(
              child:
                  Text((dashboardInterector.value as DashboardFailed).message),
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      SizedBox(
                        height: 50.0,
                        width: 150.0,
                        child: RadioMenuButton<bool>(
                          value: true,
                          groupValue: hasTwoImages.value,
                          onChanged: (value) => hasTwoImages.value = true,
                          child: const Text('2 Imagens'),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: GestureDetector(
                    onTap: () async {
                      final FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.image,
                      );

                      final platformFile = result?.files.first;
                      if (platformFile != null) {
                        image.value = File(platformFile.path!);
                      }
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
                              );

                              final platformFile = result?.files.first;

                              if (platformFile != null) {
                                image2.value = File(platformFile.path!);
                              }
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: image2.value == null
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
                        )
                      : const SizedBox.shrink(),
                ),
                if (loginInterector.user!.isAdm)
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text('Coloque o tempo de duração em segundos'),
                  ),
                if (loginInterector.user!.isAdm)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
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
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      secondsFocus.unfocus();
                      if (loginInterector.user!.isAdm) {
                        if (_formKey.currentState!.validate()) {
                          if (hasTwoImages.value) {
                            if (image.value != null && image2.value != null) {
                              dashboardInterector.addAD(
                                  image: image.value!,
                                  image2: image2.value!,
                                  seconds: int.parse(secondsController.text));
                            }
                          } else {
                            if (image.value != null) {
                              dashboardInterector.addAD(
                                  image: image.value!,
                                  seconds: int.parse(secondsController.text));
                            }
                          }
                        }
                      } else {
                        if (hasTwoImages.value) {
                          if (image.value != null && image2.value != null) {
                            dashboardInterector.addAD(
                                image: image.value!,
                                image2: image2.value!,
                                seconds: 30);
                          }
                        } else {
                          if (image.value != null) {
                            dashboardInterector.addAD(
                                image: image.value!, seconds: 30);
                          }
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
