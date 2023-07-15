import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';
// import 'package:my_mentor/screens/home_screen.dart';
// import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  // UserCredentialModel credentialModel=UserCredentialModel(email:"sa",password: "dfsd");

  Future<void> signUpWithEmailPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      // HomeScreen();
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

  Future<void> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        throw Exception("Wrong Password");
      } else if (e.code == "invalid-email") {
        throw Exception("Check with your email");
      } else if (e.code == "user-disabled") {
        throw Exception("Invalid User");
      } else if (e.code == "user-not-found") {
        throw Exception("User not Found");
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updatePassword(
      {required String email,
      required String oldPassword,
      required String newPassword}) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: oldPassword);
      await _firebaseAuth.currentUser!
          .reauthenticateWithCredential(credential)
          .then(
              (value) => _firebaseAuth.currentUser!.updatePassword(newPassword))
          .catchError((error) {
        throw Exception(error.toString());
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth!.idToken, accessToken: googleAuth.accessToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
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
