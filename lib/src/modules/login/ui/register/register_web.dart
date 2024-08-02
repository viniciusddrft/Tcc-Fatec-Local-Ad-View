import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/login/interactor/login_interactor.dart';
import '../../interactor/login_state.dart';

class RegisterWeb extends StatefulWidget {
  const RegisterWeb({super.key});

  @override
  State<RegisterWeb> createState() => _RegisterWebState();
}

class _RegisterWebState extends State<RegisterWeb> {
  final loginInterator = Modular.get<Logininteractor>();
  final emailController = TextEditingController();
  final tokenController = TextEditingController();
  final passwordController = TextEditingController();
  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();
  final _focusNodeToken = FocusNode();

  @override
  void initState() {
    loginInterator.addListener(() {
      if (loginInterator.value is RegisteredSuccess) {
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

        Future.delayed(const Duration(seconds: 1),
            () => Modular.to.navigate('/login/login'));
      } else if (loginInterator.value is LoginFailed) {
        showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: Text('Você não tem permissão para criar usuario!'),
                ),
              );
            },
            backgroundColor: Colors.grey);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    loginInterator.dispose();
    tokenController.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeToken.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: loginInterator,
        builder: (context, value, child) => Center(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 60),
                    child: TextFormField(
                      controller: tokenController,
                      focusNode: _focusNodeToken,
                      decoration: const InputDecoration(
                        labelText: 'Token',
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
                        loginInterator.register(
                            email: emailController.text,
                            password: passwordController.text,
                            token: tokenController.text);
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
      ),
    );
  }
}
