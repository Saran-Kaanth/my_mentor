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
      print("initial data started");
      await dbRef.child(currentUser!.uid).once().then((value) {
        Map allData = value.snapshot.value as Map;

        allData.forEach((key, value) {
          profileData = UserProfileDetailsModel.fromMap(allData);
        });
        print(profileData!.city);
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
      await dbRef.orderByChild("city").equalTo(city).once().then((value) {
        // print(value.snapshot.value);
        if (value.snapshot.value == null) {
          return locBasedUsersList;
        } else {
          Map locBasedUsers = value.snapshot.value as Map;
          for (var element in locBasedUsers.values) {
            if (element["email"] != currentUser!.email) {
              locBasedUsersList.add(UserProfileDetailsModel.fromMap(element));
            }
          }
        }
      });
    } catch (e) {
      // print(e.toString());
      throw Exception(e);
    }

    return locBasedUsersList;
  }

  Future<List<UserProfileDetailsModel>>? retrieveMatchedUsers(
      String searchText) async {
    List<UserProfileDetailsModel> matchedUsersList = [];
    try {
      await dbRef
          .orderByChild("displayName")
          .startAt(searchText)
          .limitToFirst(10)
          .once()
          .then((value) {
        // print(value.snapshot.value);
        if (value.snapshot.value == null) {
          return matchedUsersList;
        } else {
          Map matchedUsersData = value.snapshot.value as Map;
          // print(matchedUsersData.length);
          for (var element in matchedUsersData.values) {
            // print(element["displayName"] == searchText);
            if (element["email"] != currentUser!.email) {
              if (element["displayName"] == searchText) {
                matchedUsersList.clear();
                matchedUsersList.add(UserProfileDetailsModel.fromMap(element));
                break;
              } else {
                matchedUsersList.add(UserProfileDetailsModel.fromMap(element));
              }
            }
          }
          return matchedUsersList;
          // print("satisfies:" +
          //     matchedUsersData.values.contains(searchText).toString());
          // matchedUsersData.values.forEach((element) {
          //   print(element);
          //   print(element["displayName"]);
          // });
          // print(matchedUsersData.values.contains(searchText));
          // matchedUsersData.values.forEach((element) {})
          // for (var element in matchedUsersData.values) {
          //   matchedUsersList.add(UserProfileDetailsModel.fromMap(element));
          //   //   print(element["displayName"] == searchText);
          //   //   if (element["displayName"] == searchText) {
          //   //     matchedUsersList.clear();
          //   //     matchedUsersList.add(UserProfileDetailsModel.fromMap(element));
          //   //     return matchedUsersList;
          //   //   } else {
          //   //     matchedUsersList.add(UserProfileDetailsModel.fromMap(element));
          //   //   }
          //   //   return matchedUsersList;
          //   // }
          // }
        }

        // return matchedUsersList;
      });
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
    return matchedUsersList;
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
