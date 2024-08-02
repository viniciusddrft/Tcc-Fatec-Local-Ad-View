import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'src/app_module.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
          backgroundColor: Colors.deepPurple,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            textStyle: const TextStyle(fontSize: 20),
            foregroundColor: Colors.white,
          ),
        ),
        colorScheme: const ColorScheme(
          onSurface: Color(0xfffbfbfb),
          brightness: Brightness.light,
          error: Colors.deepPurple,
          surfaceContainerHighest: Colors.black,
          onError: Colors.red,
          onPrimary: Colors.deepPurple,
          onSecondary: Colors.deepPurple,
          primary: Colors.black,
          secondary: Colors.deepPurple,
          surface: Colors.deepPurple,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: Modular.routerConfig,
    );
  }
}
