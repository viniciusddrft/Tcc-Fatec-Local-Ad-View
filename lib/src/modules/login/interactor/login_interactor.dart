import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/login/interactor/entities/user.dart';
import 'package:local_ad_view/src/modules/login/interactor/interface/login_service_interface.dart';
import 'package:local_ad_view/src/modules/login/interactor/login_state.dart';
import 'package:crypto/crypto.dart';

class Logininteractor extends ValueNotifier<LoginState> {
  Logininteractor(this._loginService) : super(const LoginInitial());

  final LoginServiceInterface _loginService;
  static UserEntity? _user;
  bool isLogout = false;

  UserEntity? get user => _user;

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
    if (value is LoggedSuccess) {
      isLogout = false;
      _user = (value as LoggedSuccess).user;
    }
  }

  void checkUserAuthentication() async {
    if (!isLogout) {
      value = const LoginLoading();
      value = await _loginService.checkUserAuthentication();
      if (value is LoggedSuccess) {
        _user = (value as LoggedSuccess).user;
      }
    }
  }

  void logout() async {
    value = const LoginInitial();
    isLogout = true;
    Modular.to.pushReplacementNamed('/login/login');
  }
}
