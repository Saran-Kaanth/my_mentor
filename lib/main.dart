import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_mentor/screens/start_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "My Mentor",
    theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        // textTheme: GoogleFonts.mavenProTextTheme(),
        textTheme: GoogleFonts.mavenProTextTheme(),
        // textTheme:
        //     TextTheme(headline1: GoogleFonts.mavenPro(color: Colors.white)),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey.shade800),
        colorScheme: ColorScheme.dark(),
        useMaterial3: true),
    home: StartScreen(),
  ));

  // runApp(MaterialApp())
}


