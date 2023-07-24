import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';
import 'package:my_mentor/blocs/postBloc/post_bloc.dart';
import 'package:my_mentor/blocs/profileBloc/profile_bloc.dart';
import 'package:my_mentor/data/repositories/auth_repository.dart';
import 'package:my_mentor/data/repositories/models/user.dart';
// import 'package:my_mentor/screens/academic_details_screen.dart';
import 'package:my_mentor/screens/home_screen.dart';
import 'package:my_mentor/screens/login_screen.dart';
import 'package:my_mentor/screens/profile_details_screen.dart';
import 'package:my_mentor/screens/route_screen.dart';
import 'package:my_mentor/screens/signup_screen.dart';
import 'package:my_mentor/screens/splash_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => AuthRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(authRepository: AuthRepository()),
            ),
            BlocProvider(
              create: (context) => ProfileBloc(),
            ),
            BlocProvider(
              create: (context) => PostBloc(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "My Mentor",
            themeMode: ThemeMode.system,
            theme: ThemeData(
              primaryColor: Colors.pink,
              primarySwatch: Colors.pink,
              brightness: Brightness.light,
              textTheme: GoogleFonts.mavenProTextTheme(),
            ),
            darkTheme: ThemeData(
              primaryColor: Colors.blue.shade800,
              primarySwatch: Colors.blue,
              brightness: Brightness.dark,
              textTheme: GoogleFonts.mavenProTextTheme(),
            ),
            home: const SplashScreen(),
            routes: {
              'login': (context) => LoginScreen(),
              "signup": (context) => SignUpScreen(),
              "home": (context) => const HomeScreen(),
              "splash": (context) => const SplashScreen(),
              "route": (context) => const RouteScreen(),
              // "profiledetails": (context) => ProfileDetailsScreen(),
              // "academicDetails": (context) => AcademicDetailsScreen(),
            },
          ),
        ));
  }
}
