import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_mentor/data/repositories/models/user.dart';

class ProfileRepository {
  final currentUser = FirebaseAuth.instance.currentUser;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref("profileDetails");

  Future<void> updateUserProfile(
      UserProfileDetailsModel userProfileDetailsModel) async {
    try {
      await dbRef
          .child(currentUser!.uid)
          .update(userProfileDetailsModel.toMap())
          .then((value) => print("Data Updated"))
          .onError((error, stackTrace) => print(error.toString()));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserProfileDetailsModel> retrieveUserProfile() async {
    UserProfileDetailsModel? profileData;
    try {
      await dbRef.child(currentUser!.uid).once().then((value) {
        Map allData = value.snapshot.value as Map;

        allData.forEach((key, value) {
          profileData = UserProfileDetailsModel.fromMap(allData);
        });

        return profileData;
      });
    } catch (e) {
      throw Exception(e.toString());
    }
    return profileData!;
  }
}
