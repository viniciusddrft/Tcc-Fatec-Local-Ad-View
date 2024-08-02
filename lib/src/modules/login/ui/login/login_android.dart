import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/login/interactor/login_state.dart';

import '../../interactor/login_interactor.dart';

class LoginAdnroid extends StatefulWidget {
  const LoginAdnroid({super.key});

  @override
  State<LoginAdnroid> createState() => _LoginAdnroidState();
}

class _LoginAdnroidState extends State<LoginAdnroid> {
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
        Modular.to.navigate('/dashboard/dashboard');
      }
    });
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(
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
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => _isObfuscatePassword.value =
                              !_isObfuscatePassword.value,
                          child: Icon(_isObfuscatePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility),
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
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _logininteractor.login(
                            email: _emailController.text,
                            password: _passwordController.text);
                      }
                    },
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
