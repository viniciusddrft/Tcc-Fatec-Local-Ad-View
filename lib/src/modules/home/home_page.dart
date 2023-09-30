import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_ad_view/src/home/components/ad_widget.dart';
import 'package:local_ad_view/src/home/home_controller.dart';
import 'package:local_ad_view/src/shared/models/ad_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomeController homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: homeController.adsSnapshot,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<AdModel>> snapshot) {
        if (snapshot.hasData) {
          return AdWidget(
            homeController: homeController
              ..ads = snapshot.data!.docs.map((e) => e.data()).toList(),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
