import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_mentor/data/models/user.dart';

class ProfileRepository {
  late UserProfileDetailsModel localCurrentUserModel;
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
      await currentUser!.updateDisplayName(userProfileDetailsModel.displayName);
      await currentUser!.updatePhotoURL(userProfileDetailsModel.photoUrl);
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

  Future<List<UserProfileDetailsModel>>? retrieveLocBasedUsers(
      String city) async {
    List<UserProfileDetailsModel> locBasedUsersList = [];
    try {
      await dbRef.orderByChild("city").startAt(city).once().then((value) {
        print(value.snapshot.value);
        if (value.snapshot.value == null) {
          return locBasedUsersList;
        } else {
          Map locBasedUsers = value.snapshot.value as Map;
          locBasedUsers.values.forEach((element) {
            locBasedUsersList.add(UserProfileDetailsModel.fromMap(element));
          });
        }
      });
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }

    return locBasedUsersList;
  }

  // Future<List<UserProfileDetailsModel>> retrieveLocBasedUsers(){

  // }

  // -------------------------

  Future<String> retrieveAuthorImgName(String authorId) async {
    String authorImgName = "";
    try {
      // await dbRef.child(authorId).child("photourl").once().then((value) {
      //   print(value.snapshot.value.runtimeType);
      //   print("value:"+value.snapshot.value.toString());
      //   authorImgName.add(value.snapshot.value as String);
      // });
      await dbRef.child(authorId).child("photoUrl").once().then((value) {
        print(value.snapshot.value);
        authorImgName = value.snapshot.value as String;
      });
      // await dbRef.child(authorId).child("displayName").once().then((value) {
      //   print(value.snapshot.value);
      //   authorImgName.add(value.snapshot.value as String);
      // });
      if (authorImgName == "") {
        print("empty");
        return authorImgName;
      } else {
        print(authorImgName);
        return authorImgName;
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
    // return authorImgName;
  }
}
