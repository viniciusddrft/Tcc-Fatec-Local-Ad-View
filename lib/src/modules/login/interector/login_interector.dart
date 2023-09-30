import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:local_ad_view/src/modules/login/interector/interface/login_service_interface.dart';
import 'package:local_ad_view/src/modules/login/interector/login_state.dart';
import 'package:crypto/crypto.dart';

class LoginInteretor extends ValueNotifier<LoginState> {
  LoginInteretor(this._loginService) : super(const LoginInitial());

  final LoginServiceInterface _loginService;

  void register(
      {required String email,
      required String password,
      required String token}) async {
    value = const LoginLoading();

    final List<int> bytes = utf8.encode(token.trim());

    final hash = sha512.convert(bytes);

    value = await _loginService.register(
        email.trim(), password.trim(), hash.toString());
  }

  void login({required String email, required String password}) async {
    value = const LoginLoading();
    value = await _loginService.login(email.trim(), password.trim());
  }

  void checkUserAuthentication() async {
    value = const LoginLoading();
    value = await _loginService.checkUserAuthentication();
  }
}
