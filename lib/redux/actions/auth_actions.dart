import 'dart:async';
import '../../models/models.dart';

class RegisterAction {
  final Completer completer = new Completer();
  final String name;
  final String email;
  final String password;

  RegisterAction(this.name, this.email, this.password);
}
class RegisterSuccessAction {
  final User user;

  RegisterSuccessAction(this.user);
}
class RegisterFailureAction {}

class LoginAction {
  final Completer completer = new Completer();
  final String email;
  final String password;

  LoginAction(this.email, this.password);
}
class LoginSuccessAction {
  final User user;

  LoginSuccessAction(this.user);
}
class LoginFailureAction {}

class LogoutAction {
  final Completer completer = new Completer();
}
class LogoutSuccessAction {}
class LogoutFailureAction {}
