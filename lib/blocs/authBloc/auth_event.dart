part of 'auth_bloc.dart';

class UserCredentialModel {
  final String email;
  final String password;

  UserCredentialModel({required this.email, required this.password});
}

abstract class AuthEvent {}

class Sample {
  Sample(UserCredentialModel) {
    print(UserCredentialModel.email.toString());
  }
}

class AuthSignUpEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  AuthSignUpEmailPasswordEvent(this.email, this.password);
}

class AuthSignInEmailPasswordEvent extends AuthEvent {
  UserCredentialModel credentialModel;
  AuthSignInEmailPasswordEvent(this.credentialModel);
}

class AuthUpdatePasswordEvent extends AuthEvent {
  final String email;
  final String oldPassword;
  final String newPassword;

  AuthUpdatePasswordEvent(this.email, this.oldPassword, this.newPassword);
}

class AuthSignOutEvent extends AuthEvent {}

class AuthSignInGoogleEvent extends AuthEvent {}

class EmailValidateEvent extends AuthEvent {
  final String email;
  EmailValidateEvent(this.email);
}

class PasswordValidateEvent extends AuthEvent {
  final String password;
  PasswordValidateEvent(this.password);
}

// ----------------------------------------------------------------

class AuthDataSubmittedEvent extends AuthEvent {
  final String email;
  final String password;
  AuthDataSubmittedEvent(this.email, this.password);
}
