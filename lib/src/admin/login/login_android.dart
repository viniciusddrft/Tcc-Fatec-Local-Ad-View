import 'package:flutter/material.dart';

class LoginAdnroid extends StatefulWidget {
  const LoginAdnroid({super.key});

  @override
  State<LoginAdnroid> createState() => _LoginAdnroidState();
}

class _LoginAdnroidState extends State<LoginAdnroid> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema de avisos Fatec'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Form(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome de usuario',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.05, bottom: size.height * 0.05),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/dashboard',
                        arguments: {
                          'isAndroid': true,
                          'isWeb': false,
                          'isIos': false
                        },
                      );
                    },
                    child: const Center(
                      child: Text('Entrar'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
