import 'package:local_ad_view/src/modules/login/interector/login_state.dart';

abstract interface class LoginServiceInterface {
  Future<LoginState> login(String email, String password);
  Future<LoginState> register(String email, String password, String token);
  Future<LoginState> checkUserAuthentication();
}
