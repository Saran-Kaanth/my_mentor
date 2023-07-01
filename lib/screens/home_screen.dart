import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen();
  final User user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            Text(
              user.email.toString(),
              style: TextStyle(color: Colors.deepOrangeAccent),
            ),
            SizedBox(
              height: 10,
            ),
            CupertinoButton(
                child: Text(
                  "Sign out",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                })
          ],
        )),
      ),
    );
  }
}

Future<User?> getCurrentUser() async {
  User? user = await FirebaseAuth.instance.currentUser;
  return user;
}
