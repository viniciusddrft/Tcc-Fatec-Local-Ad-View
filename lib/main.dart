import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/routes/routes.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fatec avisos',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      onGenerateRoute: Routes.manageRoutes,
      initialRoute: kIsWeb ? '/home' : '/adminLocalAdView',
    );
  }
}
