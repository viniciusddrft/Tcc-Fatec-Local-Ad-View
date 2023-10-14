import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../interector/login_interector.dart';
import '../../interector/login_state.dart';

class LoginWeb extends StatefulWidget {
  const LoginWeb({super.key});

  @override
  State<LoginWeb> createState() => _LoginWebState();
}

class _LoginWebState extends State<LoginWeb> {
  final loginInteretor = Modular.get<LoginInterector>();
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
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }

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
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.05),
                child: SizedBox(
                  width: size.width * 0.3,
                  child: TextFormField(
                    controller: passwordController,
                    focusNode: _focusNodePassword,
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
                    onPressed: () => loginInteretor.login(
                        email: emailController.text,
                        password: passwordController.text),
                    child: const Center(
                      child: Text(
                        'Entrar',
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
                  child: TextButton(
                    onPressed: () => Modular.to.navigate('/login/register'),
                    child: const Text('Cadastrar-se'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
