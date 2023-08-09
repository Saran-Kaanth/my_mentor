// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';
import 'package:my_mentor/blocs/postBloc/post_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String email = "";
  String password = "";
  final TextEditingController _loginScreenUsernameController =
      TextEditingController();
  final TextEditingController _loginScreenPasswordController =
      TextEditingController();

  void dispose() {
    _loginScreenPasswordController.dispose();
    _loginScreenPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<AuthBloc>(context);
    // final postBloc = BlocProvider.of<PostBloc>(context);
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flex(
            direction: Axis.vertical,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipPath(
                      // clipBehavior: Clip.antiAliasWithSaveLayer,
                      clipper: CustomDiagonalClipper(),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.9,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          "assets/images/office_animated.png",
                          fit: BoxFit.fill,
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: RadialGradient(
                            colors: [Colors.blueGrey, Colors.white70])),
                    child: SizedBox(
                        child: Icon(
                      Icons.lock_person,
                      color: Colors.white,
                      size: 30,
                    )),
                  )
                ],
              )
            ],
          ),
          Flexible(
            child: Container(
              // color: Colors.amber,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
          ),
          Flexible(
              child: SizedBox(
            height: size.height / 4,
            child: Container(
              height: MediaQuery.of(context).size.height / 4.5,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrangeAccent),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        controller: _loginScreenUsernameController,
                        style: TextStyle(color: Colors.amber),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle_rounded),
                            contentPadding: EdgeInsets.only(bottom: 2, left: 5),
                            hintText: "Username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.lightGreenAccent))),
                        onChanged: (value) {
                          email = _loginScreenUsernameController.text;
                          bloc.add(EmailValidateEvent(email));
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        controller: _loginScreenPasswordController,
                        style: TextStyle(color: Colors.amber),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.key_rounded),
                            contentPadding: EdgeInsets.only(bottom: 2, left: 5),
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.lightGreenAccent))),
                        obscureText: true,
                        obscuringCharacter: "*",
                        onChanged: (value) {
                          password = _loginScreenPasswordController.text;
                          bloc.add(PasswordValidateEvent(password));
                        },
                      ),
                    ),
                  ),
                  BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
                    if (state is AuthLoggedInState) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "route", (route) => false);
                      // postBloc.add(AllPostRetrieveEvent());
                    }
                    //   if (state is AuthLoggedInState) {
                    //   Navigator.pushAndRemoveUntil(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => ProfileDetailsScreen(
                    //           userProfileDetailsModel:
                    //               state.userProfileDetailsModel,
                    //         ),
                    //       ),
                    //       (route) => false);
                    //   // Navigator.pushNamedAndRemoveUntil(
                    //   //     context, "profiledetails", (route) => false);
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     content: Text("Logged In Successfully"),
                    //     backgroundColor: Colors.deepOrangeAccent,
                    //   ));
                    // }
                    // else if ((state is AuthLoadingState)) {
                    //   showDialog(
                    //       context: context,
                    //       barrierDismissible: false,
                    //       builder: (_) {
                    //         return Dialog(
                    //           backgroundColor: Colors.grey.shade800,
                    //           child: Padding(
                    //             padding: EdgeInsets.symmetric(vertical: 30),
                    //             child: Column(
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: [
                    //                 CircularProgressIndicator(),
                    //                 SizedBox(height: 5),
                    //                 Text("Logging In")
                    //               ],
                    //             ),
                    //           ),
                    //         );
                    //       });
                    // }
                    // } else if (state is AuthLoadedState) {
                    //   Navigator.pop(context);
                    // }
                  }, builder: (context, state) {
                    if (state is AuthErrorState) {
                      return SizedBox(
                        height: 20,
                        child: Text(
                          state.errorMessage,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: 20,
                      );
                    }
                  }),
                  SizedBox(
                    height: 60,
                    child: Container(
                      padding: EdgeInsets.all(13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // padding: EdgeInsets.all(),
                            width: MediaQuery.of(context).size.width / 3.2,
                            // height: MediaQuery.of(context).size.width / 7,
                            decoration: BoxDecoration(
                                // color: Colors.deepOrangeAccent,
                                border: Border.all(color: Colors.blue.shade900),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              highlightColor: Colors.blueGrey.withOpacity(1),
                              // splashColor: Colors.deepOrangeAccent.shade700,
                              splashColor: Colors.blueGrey,
                              onTap: () {
                                bloc.add(AuthSignInGoogleEvent());
                              },
                              // customBorder: Border.all(color: Colors.amber),
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/google.png"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthLoadingState) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return Container(
                                width: MediaQuery.of(context).size.width / 2.4,
                                // height: MediaQuery.of(context).size.width / 7,
                                decoration: BoxDecoration(
                                    // color: Colors.deepOrangeAccent,
                                    border: Border.all(
                                        color: Colors.deepOrangeAccent
                                            .withOpacity(0.5)),
                                    // gradient: LinearGradient(colors: [
                                    //   Colors.white,
                                    //   Colors.indigo.shade400
                                    // ]),
                                    borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  highlightColor:
                                      Colors.deepOrangeAccent.withOpacity(1),
                                  // splashColor: Colors.deepOrangeAccent.shade700,
                                  splashColor: Colors.deepOrangeAccent,
                                  onTap: () {
                                    UserCredentialModel credentialModel =
                                        UserCredentialModel(
                                            email:
                                                _loginScreenUsernameController
                                                    .text,
                                            password:
                                                _loginScreenPasswordController
                                                    .text);
                                    bloc.add(AuthSignInEmailPasswordEvent(
                                        credentialModel));
                                  },
                                  // customBorder: Border.all(color: Colors.amber),
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Login",
                                      style: GoogleFonts.mavenPro(
                                          color: Colors.white,
                                          // fontWeight: FontWeight.w400,
                                          fontSize: 23),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 28,
            child: Container(
              alignment: Alignment.topLeft,
              width: size.width / 1.2,
              height: size.height / 1.1,
              // padding: EdgeInsets.all(size.width / 5),
              // color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Are you a new user? ",
                    style:
                        GoogleFonts.mavenPro(color: Colors.white, fontSize: 13),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,

                    // height: MediaQuery.of(context).size.width / 7,
                    decoration: BoxDecoration(
                        // color: Colors.deepOrangeAccent,
                        border:
                            Border.all(color: Colors.green.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      highlightColor: Colors.green.withOpacity(1),
                      // splashColor: Colors.deepOrangeAccent.shade700,
                      splashColor: Colors.green.shade700,
                      onTap: () {
                        Navigator.pushNamed(context, "signup");
                      },
                      // customBorder: Border.all(color: Colors.amber),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.mavenPro(
                              color: Colors.white,
                              // fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    )));
  }
}

class CustomDiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height - 40)
      ..lineTo(size.width, 0.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

// class ShowDialog extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     showDialog(
//                           context: context,
//                           builder: (_) {
//                             return Dialog(
//                               backgroundColor: Colors.grey.shade800,
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 30),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     CircularProgressIndicator(),
//                                     SizedBox(height: 5),
//                                     Text("Logging In")
//                                   ],
//                                 ),
//                               ),
//                             );
//                           });
//   }
// }

// class CustomClipPath extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     double w = size.width;
//     double h = size.height;

//     final path = Path();

//     path.lineTo(0, h);
//     path.
//   }
// }

