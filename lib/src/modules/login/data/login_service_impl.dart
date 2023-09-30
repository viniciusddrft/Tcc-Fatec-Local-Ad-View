import 'package:local_ad_view/src/modules/login/interector/interface/login_service_interface.dart';
import 'package:local_ad_view/src/modules/login/interector/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginServiceImpl implements LoginServiceInterface {
  @override
  Future<LoginState> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return const LoggedSuccess();
    } catch (e) {
      return LoginFailed(e.toString());
    }
  }

  @override
  Future<LoginState> register(
      String email, String password, String token) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return const RegisteredSuccess();
    } catch (e) {
      return LoginFailed(e.toString());
    }
  }

  @override
  Future<LoginState> checkUserAuthentication() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return const LoggedSuccess();
    } else {
      return const Disconnected();
    }
  }
}
