part of 'auth_bloc.dart';

abstract class AuthEvent {
  // @override
  // List<Object?> get props => [];
}

class AuthSignUpEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  AuthSignUpEmailPasswordEvent(this.email, this.password);
}

class AuthDataSubmittedEvent extends AuthEvent {
  final String email;
  final String password;
  AuthDataSubmittedEvent(this.email, this.password);
}
