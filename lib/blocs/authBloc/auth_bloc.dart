// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mentor/data/repositories/auth_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final auth_repository = AuthRepository();
  AuthBloc() : super(AuthInitialState()) {
    on<AuthDataSubmittedEvent>((event, emit) {
      auth_repository.AuthDataModulation(
              email: event.email, password: event.password)
          .then((value) {
        print("Bloc In");
        print(value.runtimeType);
        print(value);
        if (value.toString() == "Failure") {
          emit(AuthDataFailedState(message: value.toString()));
        } else {
          emit(AuthDataAcceptedState(message: value.toString()));
        }
      });
    });
    on<AuthSignUpEmailPasswordEvent>((event, emit) async {
      try {
        emit(AuthLoadingState());
        _firebaseAuth.createUserWithEmailAndPassword(
            email: event.email, password: event.password);
        emit(AuthLoggedInState());
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak-password") {
          // throw Exception("The password is weak");
          emit(AuthErrorState("The password is weak"));
        } else if (e.code == "email-already-in-use") {
          // throw Exception("Email is already in use!");
          emit(AuthErrorState("email-already-in-use"));
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    });
  }
}
