part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthSignUpEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  AuthSignUpEmailPasswordEvent(this.email, this.password);
}

class AuthSignInGoogleEvent extends AuthEvent {}

class AuthUpdatePasswordEvent extends AuthEvent {
  final String email;
  final String oldPassword;
  final String newPassword;

  AuthUpdatePasswordEvent(this.email, this.oldPassword, this.newPassword);
}

class AuthSignOutEvent extends AuthEvent {}

class AuthDataSubmittedEvent extends AuthEvent {
  final String email;
  final String password;
  AuthDataSubmittedEvent(this.email, this.password);
}
