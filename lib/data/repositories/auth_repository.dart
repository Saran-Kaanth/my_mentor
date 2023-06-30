import 'package:firebase_auth/firebase_auth.dart';
// import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signUpWithEmailPassword(
      {required String email, required String password}) async {
    print("repo in");
    try {
      _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      // _firebaseAuth.signInWithEmailAndPassword(email: , password: password)
      // print(_firebaseAuth.currentUser!.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        throw Exception("The password is weak");
      } else if (e.code == "email-already-in-use") {
        throw Exception("Email is already in use!");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> AuthDataModulation({required email, required password}) async {
    print("Repo In");
    print(email);
    print(password);
    if (email.toString().isEmpty || password.toString().isEmpty) {
      return "Failed";
    } else {
      return "Success";
    }
  }
}
