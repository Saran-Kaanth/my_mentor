part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoggedInState extends AuthState {}

class AuthLoggedOutState extends AuthState {}

class AuthErrorState extends AuthState {
  String errorMessage;
  AuthErrorState(this.errorMessage);
}

class AuthDataFailedState extends AuthState {
  String? message;
  AuthDataFailedState({this.message});
}

class AuthDataAcceptedState extends AuthState {
  String? message;
  AuthDataAcceptedState({this.message});
}