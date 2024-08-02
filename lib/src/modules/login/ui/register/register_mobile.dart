import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/login/interactor/login_interactor.dart';
import '../../interactor/login_state.dart';

class RegisterMobile extends StatefulWidget {
  const RegisterMobile({super.key});

  @override
  State<RegisterMobile> createState() => _RegisterMobileState();
}

class _RegisterMobileState extends State<RegisterMobile> {
  final _logininteractor = Modular.get<Logininteractor>();
  final _emailController = TextEditingController();
  final _tokenController = TextEditingController();
  final _passwordController = TextEditingController();
  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();
  final _focusNodeToken = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _isObfuscatePassword = ValueNotifier<bool>(true);

  @override
  void initState() {
    _logininteractor.addListener(() {
      if (_logininteractor.value is RegisteredSuccess) {
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
            () => Modular.to.pushNamed('/login/login'));
      } else if (_logininteractor.value is LoginFailed) {
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
    _passwordController.dispose();
    _emailController.dispose();
    _logininteractor.dispose();
    _tokenController.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeToken.dispose();
    _isObfuscatePassword.dispose();
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
        valueListenable: _logininteractor,
        builder: (context, value, child) => SingleChildScrollView(
          child: Center(
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
                          builder: (context, value, child) => TextFormField(
                            controller: _passwordController,
                            focusNode: _focusNodePassword,
                            obscureText: _isObfuscatePassword.value,
                            keyboardType: TextInputType.visiblePassword,
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
                              } else if (text.length <= 8) {
                                return 'Senha muito curta';
                              } else {
                                return null;
                              }
                            },
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 60),
                      child: TextFormField(
                        controller: _tokenController,
                        focusNode: _focusNodeToken,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Token',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Coloque o Token';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _focusNodeEmail.unfocus();
                          _focusNodeEmail.unfocus();
                          if (_formKey.currentState!.validate()) {
                            _logininteractor.register(
                                email: _emailController.text,
                                password: _passwordController.text,
                                token: _tokenController.text);
                          }
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
      ),
    );
  }
}
