// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mentor/data/repositories/auth_repository.dart';
import 'package:my_mentor/data/models/user.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitialState()) {
    on<AuthSignUpEmailPasswordEvent>((event, emit) async {
      if (event.email != "" && event.password != "") {
        try {
          emit(AuthLoadingState());

          UserProfileDetailsModel initialData =
              await authRepository.signUpWithEmailPassword(
                  email: event.email, password: event.password);
          // emit(AuthLoadedState());
          emit(AuthLoggedInState(userProfileDetailsModel: initialData));
        } catch (e) {
          // emit(AuthErrorState(e.toString().substring(11)));
          emit(AuthErrorState("Give Valid Credentials!"));
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
          UserProfileDetailsModel initialData =
              await authRepository.signInWithEmailPassword(
                  email: event.credentialModel.email,
                  password: event.credentialModel.password);
          emit(AuthLoggedInState(userProfileDetailsModel: initialData));
        } catch (e) {
          emit(AuthErrorState("Give valid credentials!"));
        }
      } else {
        emit(AuthErrorState("Provide the credentials!"));
      }
    });

    on<AuthSignOutEvent>((event, emit) async {
      try {
        emit(AuthLoadingState());
        await authRepository.signOut();
        print("logged out");
        // emit(AuthLoadedState());
        emit(AuthLoggedOutState());
      } catch (e) {
        emit(AuthErrorState("Unable to Log out!"));
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
        emit(AuthErrorState("Please Try Again!"));
      }
    });

    on<AuthSignInGoogleEvent>((event, emit) async {
      try {
        emit(AuthLoadingState());

        UserProfileDetailsModel initialData =
            await authRepository.signInWithGoogle();

        emit(AuthLoggedInState(userProfileDetailsModel: initialData));
      } catch (e) {
        print("Authentication Google Error");
        print(e.toString());
        emit(AuthErrorState("Please Try Again!"));
      }
    });

    on<EmailValidateEvent>((event, emit) {
      if (EmailValidator.validate(event.email) == false || event.email == "") {
        print("Invalid");
        emit(AuthErrorState("Please enter valid email"));
      } else {
        emit(EmailValidState());
      }
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
