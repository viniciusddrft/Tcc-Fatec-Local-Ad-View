import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../interactor/login_interactor.dart';
import '../../interactor/login_state.dart';

class LoginWeb extends StatefulWidget {
  const LoginWeb({super.key});

  @override
  State<LoginWeb> createState() => _LoginWebState();
}

class _LoginWebState extends State<LoginWeb> {
  final _loginInteractor = Modular.get<Logininteractor>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();
  final _isObfuscatePassword = ValueNotifier<bool>(true);

  @override
  void initState() {
    _loginInteractor.checkUserAuthentication();
    _loginInteractor.addListener(() {
      if (_loginInteractor.value is LoggedSuccess) {
        Modular.to.navigate('/dashboard/dashboard');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
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
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2.0),
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
                  child: ValueListenableBuilder(
                      valueListenable: _isObfuscatePassword,
                      builder: (context, _, child) {
                        return TextFormField(
                          controller: passwordController,
                          focusNode: _focusNodePassword,
                          obscureText: _isObfuscatePassword.value,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            labelStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepPurple, width: 2.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.orange, width: 2.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () => _isObfuscatePassword.value =
                                  !_isObfuscatePassword.value,
                              child: Icon(
                                _isObfuscatePassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.05),
                child: SizedBox(
                  width: size.width * 0.3,
                  height: size.height * 0.06,
                  child: ValueListenableBuilder(
                    valueListenable: _loginInteractor,
                    builder: (_, value, __) => ElevatedButton(
                      onPressed: () => _loginInteractor.login(
                          email: emailController.text,
                          password: passwordController.text),
                      child: Center(
                        child: value is! LoginLoading
                            ? const Text('Entrar')
                            : const CircularProgressIndicator(
                                color: Colors.white,
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

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }
}
