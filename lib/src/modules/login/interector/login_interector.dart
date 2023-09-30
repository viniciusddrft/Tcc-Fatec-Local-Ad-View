import 'package:flutter/cupertino.dart';
import 'package:local_ad_view/src/modules/login/interector/interface/login_service_interface.dart';
import 'package:local_ad_view/src/modules/login/interector/login_state.dart';

class LoginInteretor extends ValueNotifier<LoginState> {
  LoginInteretor(this._loginService) : super(const LoginInitial());

  final LoginServiceInterface _loginService;

  void register(
      {required String email,
      required String password,
      required String token}) async {
    value = const LoginLoading();
    value = await _loginService.register(
        email.trim(), password.trim(), token.trim());
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
