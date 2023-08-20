import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mentor/blocs/postBloc/post_bloc.dart';
import 'package:my_mentor/data/models/quotes.dart';
import 'package:my_mentor/screens/login_screen.dart';
import 'package:my_mentor/screens/my_profile_screen.dart';
import 'package:my_mentor/screens/route_screen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  List<MentorQuotes> mentorQuotes = [
    MentorQuotes("Ralph Waldo Emerson",
        "“Our chief want in life is somebody who will make us do what we can.”"),
    MentorQuotes("Oprah Winfrey",
        "“A mentor is someone who allows you to see the hope inside yourself.”"),
    MentorQuotes("Lailah Gifty Akita",
        "“With careful guidance and mentorship, you will reach your highest self.”"),
    MentorQuotes("Lailah Gifty Akita", "“Great mentors give wise guidance.”"),
    MentorQuotes("Benjamin Franklin",
        "“Tell me and I forget, teach me and I may remember, involve me and I learn.”")
  ];

  List<Color> authorTextColors = [Colors.blue, Colors.deepOrangeAccent];

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => AuthService().handleAuth()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MentorQuotes randomQuote =
        mentorQuotes[Random().nextInt(mentorQuotes.length)];
    Color randomColor =
        authorTextColors[Random().nextInt(authorTextColors.length)];
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: size.height / 2.1,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
                    TyperAnimatedText(randomQuote.quote,
                        // textAlign: TextAlign.start,
                        speed: Duration(milliseconds: 30),
                        curve: Curves.decelerate,
                        textStyle: TextStyle(fontSize: 20))
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
                      TyperAnimatedText("- " + randomQuote.author,
                          // textAlign: TextAlign.justify,
                          speed: Duration(milliseconds: 80),
                          curve: Curves.easeInBack,
                          textStyle:
                              TextStyle(fontSize: 17, color: randomColor))
                    ]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: size.height / 2.1,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GradientText("My Mentor",style: TextStyle(fontSize: 30),
                          colors: [Colors.white.withAlpha(100),randomColor ]),
                          AnimatedTextKit(totalRepeatCount: 5, animatedTexts: [
                      TyperAnimatedText("...",
                          // textAlign: TextAlign.justify,
                          speed: Duration(milliseconds: 130),
                          curve: Curves.easeInBack,
                          textStyle:
                              TextStyle(fontSize: 30, color: randomColor))
                    ]),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                const LinearProgressIndicator(
                      backgroundColor: Colors.deepOrangeAccent,
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                      minHeight: 2,
                    ),
              ],
            ),
          )
        ],
      )),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: Container(
      //         // padding: EdgeInsets.all(size.width / 5),
      //         height: size.height / 3.4,
      //         width: size.width / 1.2,
      //         decoration: BoxDecoration(
      //             border: Border.all(
      //               color: Colors.deepOrangeAccent,
      //             ),
      //             borderRadius: BorderRadius.circular(8)),
      //         child: const Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           mainAxisSize: MainAxisSize.max,
      //           children: [
      //             Text(
      //               "Your App is Loading",
      //               style: TextStyle(
      //                   fontSize: 30,
      //                   fontWeight: FontWeight.w500,
      //                   color: Colors.tealAccent),
      //             ),
      //             Padding(
      //               padding: EdgeInsets.all(20.0),
      //               child: LinearProgressIndicator(
      //                 backgroundColor: Colors.deepOrangeAccent,
      //                 valueColor: AlwaysStoppedAnimation(Colors.blue),
      //                 minHeight: 2,
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

class AuthService {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          final postBloc = BlocProvider.of<PostBloc>(context);
          postBloc.add(AllPostRetrieveEvent());
          return const RouteScreen(
            selectedIndex: 0,
          );
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
