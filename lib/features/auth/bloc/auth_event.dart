import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent {}

class LoginButtonPressEvent extends AuthEvent {
  final String username;
  final String password;
  LoginButtonPressEvent({required this.username, required this.password});
}
