import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/dashboard/interactor/dashboard_interactor.dart';
import 'package:local_ad_view/src/modules/dashboard/interactor/dashboard_state.dart';
import 'package:local_ad_view/src/modules/login/interactor/login_interactor.dart';

class OnboardingAddAdMobile extends StatefulWidget {
  const OnboardingAddAdMobile({super.key});

  @override
  State<OnboardingAddAdMobile> createState() => _OnboardingAddAdMobileState();
}

class _OnboardingAddAdMobileState extends State<OnboardingAddAdMobile> {
  final image = ValueNotifier<File?>(null);
  final image2 = ValueNotifier<File?>(null);
  final hasTwoImages = ValueNotifier<bool>(false);
  final dashboardinteractor = Modular.get<DashboardInteractor>();
  final logininteractor = Modular.get<Logininteractor>();
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
                  child: Text(
                    'Anúncio adicionado com successo!',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            },
            backgroundColor: Colors.white);

        Future.delayed(
          const Duration(seconds: 1),
          () => Modular.to.pushReplacementNamed('/dashboard/dashboard'),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Adicionar Anúncio'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: AnimatedBuilder(
            animation: Listenable.merge(
                [hasTwoImages, image, image2, dashboardinteractor]),
            builder: (context, child) {
              if (dashboardinteractor.value is DashboardLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurple,
                  ),
                );
              } else if (dashboardinteractor.value is DashboardFailed) {
                return Center(
                  child: Text(
                    (dashboardinteractor.value as DashboardFailed).message,
                    style: const TextStyle(color: Colors.black),
                  ),
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
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                radioTheme: RadioThemeData(
                                  fillColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                          (_) => Colors.black),
                                ),
                              ),
                              child: RadioMenuButton<bool>(
                                value: false,
                                groupValue: hasTwoImages.value,
                                onChanged: (value) =>
                                    hasTwoImages.value = false,
                                child: const Text(
                                  '1 Imagem',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                            width: 150.0,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                radioTheme: RadioThemeData(
                                  fillColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                          (_) => Colors.black),
                                ),
                              ),
                              child: RadioMenuButton<bool>(
                                value: true,
                                groupValue: hasTwoImages.value,
                                onChanged: (value) => hasTwoImages.value = true,
                                child: const Text(
                                  '2 Imagens',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
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
                              title: const Text(
                                'Deseja remover a imagem?',
                                style: TextStyle(color: Colors.black),
                              ),
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
                                  child: const Text(
                                    'Remover Imagem',
                                    style: TextStyle(color: Colors.black),
                                  ),
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
                                        const Text(
                                          'Adiciona uma imagem.',
                                          style: TextStyle(color: Colors.black),
                                        )
                                      ]
                                    : [
                                        const Icon(Icons.done),
                                        const Text(
                                          'Imagem Adicionado!',
                                          style: TextStyle(color: Colors.black),
                                        )
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
                                      title: const Text(
                                        'Deseja remover a imagem?',
                                        style: TextStyle(color: Colors.black),
                                      ),
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
                                          child: const Text(
                                            'Remover Imagem',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
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
                                                  'Adiciona uma imagem.',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              ]
                                            : [
                                                const Icon(Icons.done),
                                                const Text(
                                                  'Imagem Adicionado!',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              ]),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    if (logininteractor.user!.isAdm)
                      const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text('Coloque o tempo de duração em segundos'),
                      ),
                    if (logininteractor.user!.isAdm)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: secondsController,
                            focusNode: secondsFocus,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Duração(segundos) ...',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurple, width: 2.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: ElevatedButton(
                        onPressed: () {
                          secondsFocus.unfocus();
                          if (logininteractor.user!.isAdm) {
                            if (_formKey.currentState!.validate()) {
                              if (hasTwoImages.value) {
                                if (image.value != null &&
                                    image2.value != null) {
                                  dashboardinteractor.addAD(
                                      image: image.value!,
                                      image2: image2.value!,
                                      seconds:
                                          int.parse(secondsController.text));
                                }
                              } else {
                                if (image.value != null) {
                                  dashboardinteractor.addAD(
                                      image: image.value!,
                                      seconds:
                                          int.parse(secondsController.text));
                                }
                              }
                            }
                          } else {
                            if (hasTwoImages.value) {
                              if (image.value != null && image2.value != null) {
                                dashboardinteractor.addAD(
                                    image: image.value!,
                                    image2: image2.value!,
                                    seconds: 30);
                              }
                            } else {
                              if (image.value != null) {
                                dashboardinteractor.addAD(
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
        ),
      ),
    );
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
}
