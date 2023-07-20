import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_mentor/data/repositories/models/user.dart';
import 'package:my_mentor/data/repositories/profile_repository.dart';

class ProfileScreen extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser!;
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref("profileDetails");
  late UserProfileDetailsModel profileData;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void retrieveData() async {
      profileData = await ProfileRepository().retrieveUserProfile();
    }

    retrieveData();
    print("hii");
    print(profileData.city);

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            left: size.width / 23,
            // right: size.width / 10,
            top: size.width / 15,
            bottom: size.width / 40),
        child: Column(
          children: [
            Stack(
              children: [
                Text(profileData.city.toString()),
                profileData.photoUrl != null
                    ? CircleAvatar(
                        backgroundImage:
                            NetworkImage(profileData.photoUrl.toString()),
                      )
                    : CircleAvatar(
                        radius: 50,
                      )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
