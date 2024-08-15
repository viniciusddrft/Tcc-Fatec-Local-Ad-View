import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/login/interactor/login_state.dart';
import '../../interactor/login_interactor.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({super.key});

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  final _logininteractor = Modular.get<Logininteractor>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();
  final _isObfuscatePassword = ValueNotifier<bool>(true);
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _logininteractor.checkUserAuthentication();
    _logininteractor.addListener(() {
      if (_logininteractor.value is LoggedSuccess) {
        Modular.to.pushNamed('/dashboard/dashboard');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('login'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: FractionallySizedBox(
            widthFactor: 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  focusNode: _focusNodeEmail,
                  keyboardType: TextInputType.emailAddress,
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
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Coloque o E-mail';
                    } else {
                      return null;
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 60),
                  child: ValueListenableBuilder(
                    valueListenable: _isObfuscatePassword,
                    builder: (context, _, child) => TextFormField(
                      focusNode: _focusNodePassword,
                      controller: _passwordController,
                      obscureText: _isObfuscatePassword.value,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                        labelText: 'Senha',
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 2.0),
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
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
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
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Coloque a senha';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ValueListenableBuilder(
                    valueListenable: _logininteractor,
                    builder: (_, value, __) => ElevatedButton(
                      onPressed: () {
                        if (value is! LoginLoading) {
                          if (_formKey.currentState!.validate()) {
                            _logininteractor.login(
                                email: _emailController.text,
                                password: _passwordController.text);
                          }
                        }
                      },
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
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    onPressed: () => Modular.to.pushNamed('/login/register'),
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

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _isObfuscatePassword.dispose();
    super.dispose();
  }
}
