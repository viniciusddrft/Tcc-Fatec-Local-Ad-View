import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_ad_view/src/modules/login/interector/interface/login_service_interface.dart';
import 'package:local_ad_view/src/modules/login/interector/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginServiceImpl implements LoginServiceInterface {
  @override
  Future<LoginState> login(String email, String password) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return LoggedSuccess(userCredential.user!);
    } catch (e) {
      return LoginFailed(e.toString());
    }
  }

  @override
  Future<LoginState> register(
      String email, String password, String token) async {
    try {
      final tokenDoc =
          await FirebaseFirestore.instance.collection('/token/').get();

      final tokenData = tokenDoc.docs.first.data();

      if (token == tokenData['token']) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        return const LoginFailed('Sem permissão para criar conta');
      }

      return const RegisteredSuccess();
    } catch (e) {
      return LoginFailed(e.toString());
    }
  }

  @override
  Future<LoginState> checkUserAuthentication() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return LoggedSuccess(user);
    } else {
      return const Disconnected();
    }
  }
}
