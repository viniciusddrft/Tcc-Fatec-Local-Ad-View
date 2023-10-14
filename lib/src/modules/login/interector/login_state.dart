import 'package:local_ad_view/src/modules/login/interector/entities/user.dart';

sealed class LoginState {
  const LoginState();
}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginFailed extends LoginState {
  const LoginFailed(this.message);
  final String message;
}

final class LoggedSuccess extends LoginState {
  final UserEntity user;
  const LoggedSuccess(this.user);
}

final class RegisteredSuccess extends LoginState {
  const RegisteredSuccess();
}

final class Disconnected extends LoginState {
  const Disconnected();
}
