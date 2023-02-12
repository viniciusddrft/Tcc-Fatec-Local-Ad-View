import 'package:flutter/material.dart';

class LoginWeb extends StatefulWidget {
  const LoginWeb({super.key});

  @override
  State<LoginWeb> createState() => _LoginWebState();
}

class _LoginWebState extends State<LoginWeb> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.3,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome de usuario',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.05),
                child: SizedBox(
                  width: size.width * 0.3,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.05),
                child: SizedBox(
                  width: size.width * 0.3,
                  height: size.height * 0.06,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, '/dashboard',
                        arguments: <String, bool>{
                          'isWeb': true,
                          'isAndroid': false,
                          'isIos': false,
                        }),
                    child: const Center(
                      child: Text(
                        'Entrar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
