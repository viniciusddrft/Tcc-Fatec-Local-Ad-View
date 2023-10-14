import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_ad_view/src/modules/login/data/adapters/user_adapter.dart';
import 'package:local_ad_view/src/modules/login/interector/entities/user.dart';
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

      final users =
          await FirebaseFirestore.instance.collection('/users/').get();

      for (QueryDocumentSnapshot doc in users.docs) {
        if ((doc.data() as Map)['user'] == userCredential.user!.email) {
          return LoggedSuccess(UserEntity(
              user: userCredential.user!.email!,
              isAdm: (doc.data() as Map)['isAdm']));
        }
      }

      return const LoginFailed('Usuario não encontrado');
    } catch (e) {
      return LoginFailed(e.toString());
    }
  }

  @override
  Future<LoginState> register(
      String email, String password, String token) async {
    try {
      final tokenAdmDoc =
          await FirebaseFirestore.instance.collection('/tokenAdm/').get();

      final tokenDoc =
          await FirebaseFirestore.instance.collection('/token/').get();

      final tokenAdmData = tokenAdmDoc.docs.first.data();
      final tokenData = tokenDoc.docs.first.data();

      if (token == tokenAdmData['token']) {
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final user = UserEntity(user: userCredential.user!.email!, isAdm: true);

        await FirebaseFirestore.instance
            .collection('/users/')
            .add(UserAdapter.toJson(user));
      }

      if (token == tokenData['token']) {
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final user =
            UserEntity(user: userCredential.user!.email!, isAdm: false);

        await FirebaseFirestore.instance
            .collection('/users/')
            .add(UserAdapter.toJson(user));
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
      final users =
          await FirebaseFirestore.instance.collection('/users/').get();

      for (QueryDocumentSnapshot doc in users.docs) {
        if ((doc.data() as Map)['user'] == user.email) {
          return LoggedSuccess(UserEntity(
              user: user.email!, isAdm: (doc.data() as Map)['isAdm']));
        }
      }
      return const Disconnected();
    } else {
      return const Disconnected();
    }
  }
}
