// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mentor/data/repositories/auth_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // FirebaseAuth _firebaseAuth = FirebaseAuth.instance;   
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitialState()) {
    on<AuthSignUpEmailPasswordEvent>((event, emit) async {
      try {
        emit(AuthLoadingState());

        await authRepository.signUpWithEmailPassword(
            email: event.email, password: event.password);

        emit(AuthLoggedInState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<AuthSignInGoogleEvent>((event, emit) async {
      try {} catch (e) {}
    });
  }
}
