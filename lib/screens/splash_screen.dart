import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_mentor/screens/login_screen.dart';
import 'package:my_mentor/screens/route_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => AuthService().handleAuth()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          // padding: EdgeInsets.all(size.width / 5),
          height: size.height / 3.4,
          width: size.width / 1.2,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.deepOrangeAccent,
              ),
              borderRadius: BorderRadius.circular(8)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Your App is Loading",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.tealAccent),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.orangeAccent,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  minHeight: 25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AuthService {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return RouteScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}


// Future.delayed(const Duration(milliseconds: 5000), () {
    //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //     if (user == null) {
    //       print("User is logged out");
    //       Navigator.pushReplacementNamed(context, "login");
    //     } else {
    //       print(user);
    //       print("User is Logged in");
    //       print(context);
    //       Navigator.pushReplacementNamed(context, "home");
    //     }
    //   });
    // });
