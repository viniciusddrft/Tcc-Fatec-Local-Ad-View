import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/login/interector/login_interector.dart';
import '../../interector/login_state.dart';

class RegisterAndroid extends StatefulWidget {
  const RegisterAndroid({super.key});

  @override
  State<RegisterAndroid> createState() => _RegisterAndroidState();
}

class _RegisterAndroidState extends State<RegisterAndroid> {
  final loginInteretor = Modular.get<LoginInteretor>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();

  @override
  void initState() {
    loginInteretor.addListener(() {
      if (loginInteretor.value is RegisteredSuccess) {
        showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: Text('Usuario criado com successo!'),
                ),
              );
            },
            backgroundColor: Colors.grey);

        Future.delayed(const Duration(seconds: 2),
            () => Modular.to.navigate('/login/login'));
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
        title: const Text('Cadastro'),
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
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _focusNodeEmail.unfocus();
                      _focusNodeEmail.unfocus();
                      loginInteretor.register(
                          email: emailController.text,
                          password: passwordController.text,
                          token: '');
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
