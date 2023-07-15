// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mentor/data/repositories/auth_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitialState()) {
    on<AuthSignUpEmailPasswordEvent>((event, emit) async {
      if (event.email != "" && event.password != "") {
        try {
          emit(AuthLoadingState());

          await authRepository.signUpWithEmailPassword(
              email: event.email, password: event.password);

          emit(AuthLoggedInState());
        } catch (e) {
          emit(AuthErrorState(e.toString().substring(11)));
        }
      } else {
        emit(AuthErrorState("Provide the credentials!"));
      }
    });

    on<AuthSignInEmailPasswordEvent>((event, emit) async {
      if (event.credentialModel.email != "" &&
          event.credentialModel.password != "") {
        try {
          emit(AuthLoadingState());
          await authRepository.signInWithEmailPassword(
              email: event.credentialModel.email,
              password: event.credentialModel.password);
          emit(AuthLoggedInState());
        } catch (e) {
          emit(AuthErrorState(e.toString().substring(11)));
        }
      } else {
        emit(AuthErrorState("Provide the credentials!"));
      }
    });

    on<AuthSignOutEvent>((event, emit) async {
      try {
        emit(AuthLoadingState());
        await authRepository.signOut();
        emit(AuthLoggedOutState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<AuthUpdatePasswordEvent>((event, emit) async {
      try {
        emit(AuthLoadingState());
        await authRepository.updatePassword(
            email: event.email,
            oldPassword: event.oldPassword,
            newPassword: event.newPassword);
        emit(AuthPasswordUpdatedSuccessState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<AuthSignInGoogleEvent>((event, emit) async {
      try {
        emit(AuthLoadingState());

        await authRepository.signInWithGoogle();

        emit(AuthLoggedInState());
      } catch (e) {
        print("Authentication Google Error");
        print(e.toString());
        emit(AuthErrorState(e.toString()));
      }
    });

    on<EmailValidateEvent>((event, emit) {
      if (EmailValidator.validate(event.email) == false || event.email == "") {
        print("Invalid");
        emit(AuthErrorState("Please enter valid email"));
      } else {
        emit(EmailValidState());
      }
      // try {
      //   if (EmailValidator.validate(event.email) == false) {
      //     print("Invalid Email");
      //     emit(AuthErrorState("Please Enter Valid Email"));
      //   } else {
      //     print("Valid Email");
      //     emit(EmailValidState());
      //   }
      // } catch (e) {
      //   throw Exception(e.toString());
      // }
    });

    on<PasswordValidateEvent>((event, emit) {
      if (event.password.length >= 8) {
        emit(PasswordValidState());
      } else {
        print("Invalid");
        emit(AuthErrorState("Please enter valid password"));
      }
    });
  }
}
