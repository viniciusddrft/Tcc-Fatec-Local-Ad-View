import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/login/interector/login_state.dart';

import '../../interector/login_interector.dart';

class LoginAdnroid extends StatefulWidget {
  const LoginAdnroid({super.key});

  @override
  State<LoginAdnroid> createState() => _LoginAdnroidState();
}

class _LoginAdnroidState extends State<LoginAdnroid> {
  final loginInteretor = Modular.get<LoginInteretor>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();

  @override
  void initState() {
    loginInteretor.checkUserAuthentication();

    loginInteretor.addListener(() {
      if (loginInteretor.value is LoggedSuccess) {
        Modular.to.navigate('/dashboard/dashboard');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    loginInteretor.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('login'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          child: FractionallySizedBox(
            widthFactor: 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  focusNode: _focusNodeEmail,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 60),
                  child: TextFormField(
                    focusNode: _focusNodePassword,
                    controller: passwordController,
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
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => loginInteretor.login(
                        email: emailController.text,
                        password: passwordController.text),
                    child: const Center(
                      child: Text('Entrar'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    onPressed: () => Modular.to.navigate('/login/register'),
                    child: const Text('Cadastrar-se'),
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
