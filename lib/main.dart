import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';
import 'package:my_mentor/data/repositories/auth_repository.dart';
import 'package:my_mentor/screens/home_screen.dart';
import 'package:my_mentor/screens/login_screen.dart';
import 'package:my_mentor/screens/signup_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "My Mentor",
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              textTheme: GoogleFonts.mavenProTextTheme(),
              colorScheme: ColorScheme.dark(),
              useMaterial3: true),
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return HomeScreen();
                } else {
                  return LoginScreen();
                }
              }),
          routes: {
            'login': (context) => LoginScreen(),
            "signup": (context) => SignUpScreen(),
            "home": (context) => HomeScreen()
          },
        ),
      )));

  // runApp(MaterialApp())
}
