import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_mentor/data/models/user.dart';
// import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';
// import 'package:my_mentor/screens/home_screen.dart';
// import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  User? currentUser;
  // UserCredentialModel credentialModel=UserCredentialModel(email:"sa",password: "dfsd");
  // UserProfileDetailsModel dummyUserProfileModel = UserProfileDetailsModel();
  Future<dynamic> signUpWithEmailPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      currentUser = _firebaseAuth.currentUser;
      return await initialDataSetup(
          userCredential.additionalUserInfo!.isNewUser);
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

  Future<UserProfileDetailsModel> initialDataSetup(bool isNewUser) async {
    print(currentUser!.uid);
    UserProfileDetailsModel userProfileDetailsModel = UserProfileDetailsModel(
        currentUser!.uid,
        currentUser!.displayName != "" ? currentUser!.displayName : null,
        null,
        null,
        currentUser!.photoURL == "" ? null : currentUser!.photoURL,
        null,
        null,
        currentUser!.email,
        null,
        null,
        null,
        null,
        [],
        0,
        [],
        false,
        currentUser!.emailVerified);
    if (isNewUser) {
      await _dbRef
          .child("profileDetails")
          .child(currentUser!.uid.toString())
          .set(userProfileDetailsModel.toMap())
          .then((value) => print("inital data stored"))
          .onError((error, stackTrace) => print(error.toString()));
      return userProfileDetailsModel;
    }

    return userProfileDetailsModel;
  }

  Future<dynamic> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      currentUser = _firebaseAuth.currentUser;
      UserProfileDetailsModel userProfileDetailsModel = UserProfileDetailsModel(
          currentUser!.uid,
          currentUser!.displayName != "" ? currentUser!.displayName : null,
          null,
          null,
          currentUser!.photoURL == "" ? null : currentUser!.photoURL,
          null,
          null,
          currentUser!.email,
          null,
          null,
          null,
          null,
          [],
          0,
          [],
          false,
          currentUser!.emailVerified);
      return userProfileDetailsModel;
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

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth!.idToken, accessToken: googleAuth.accessToken);
      UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      currentUser = _firebaseAuth.currentUser;
      print(authResult.additionalUserInfo!.profile);
      return await initialDataSetup(authResult.additionalUserInfo!.isNewUser);
      // if (authResult.additionalUserInfo!.isNewUser) {
      //   return await initialDataSetup();
      // }
      // return;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> AuthDataModulation({required email, required password}) async {
    if (email.toString().isEmpty || password.toString().isEmpty) {
      return "Failed";
    } else {
      return "Success";
    }
  }
}
