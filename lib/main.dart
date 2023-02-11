import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/context/platform_run.dart';
import 'src/routes/routes.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final PlatformType type;

  @override
  void initState() {
    if (kIsWeb) {
      type = PlatformType.web;
    } else if (Platform.isAndroid) {
      type = PlatformType.android;
    } else {
      type = PlatformType.ios;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlataformModel(
      type: type,
      child: MaterialApp(
        title: 'Fatec avisos',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        onGenerateRoute: Routes.manageRoutes,
        initialRoute: kIsWeb ? '/home' : '/adminLocalAdView',
      ),
    );
  }
}
