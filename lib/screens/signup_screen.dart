import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';
// import 'package:my_mentor/data/repositories/models/user.dart';
import 'package:my_mentor/screens/profile_details_screen.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    final authBlocSignUp = BlocProvider.of<AuthBloc>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Container(
              height: size.height / 2.5,
              width: size.width / 1.1,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrangeAccent),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              // padding: EdgeInsets.all(15),
              // color: Colors.amberAccent,
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoggedInState) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileDetailsScreen(
                            userProfileDetailsModel:
                                state.userProfileDetailsModel,
                            first: true,
                          ),
                        ),
                        (route) => false);
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, "profiledetails", (route) => false);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Logged In Successfully"),
                      backgroundColor: Colors.deepOrangeAccent,
                    ));
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      Center(
                          child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 30,
                            fontWeight: FontWeight.w200),
                      )),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        // alignment: Alignment.center,
                        // padding: EdgeInsets.all(size.width / 4),
                        child: TextField(
                          // textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          controller: _usernameController,
                          onChanged: (value) {
                            email = value;
                            authBlocSignUp.add(EmailValidateEvent(email));
                          },
                          style: TextStyle(color: Colors.amber),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_circle_rounded),
                              contentPadding:
                                  EdgeInsets.only(bottom: 2, left: 5),
                              hintText: "Email",
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: (state is EmailValidState)
                                          ? Colors.greenAccent.shade400
                                          : Colors.redAccent.shade400)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: (state is EmailValidState)
                                          ? Colors.greenAccent.shade400
                                          : Colors.redAccent.shade400))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Container(
                        // alignment: Alignment.center,
                        // padding: EdgeInsets.all(size.width / 4),
                        child: TextField(
                          // textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          controller: _passwordController,
                          onChanged: (value) {
                            password = value;
                            authBlocSignUp.add(PasswordValidateEvent(password));
                          },
                          style: TextStyle(color: Colors.amber),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.key_rounded),
                              contentPadding:
                                  EdgeInsets.only(bottom: 2, left: 5),
                              hintText: "Password",
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: (state is PasswordValidState)
                                          ? Colors.greenAccent.shade400
                                          : Colors.redAccent.shade400)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: (state is PasswordValidState)
                                          ? Colors.greenAccent.shade400
                                          : Colors.redAccent.shade400))),
                        ),
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthErrorState) {
                            return SizedBox(
                              height: 20,
                              child: Text(
                                state.errorMessage,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            // padding: EdgeInsets.all(),
                            width: MediaQuery.of(context).size.width / 3.2,
                            height: MediaQuery.of(context).size.width / 8,
                            decoration: BoxDecoration(
                                // color: Colors.deepOrangeAccent,
                                border: Border.all(color: Colors.blue.shade900),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              highlightColor: Colors.blueGrey.withOpacity(1),
                              // splashColor: Colors.deepOrangeAccent.shade700,
                              splashColor: Colors.blueGrey,
                              onTap: () {
                                authBlocSignUp.add(AuthSignInGoogleEvent());
                              },
                              // customBorder: Border.all(color: Colors.amber),
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                // alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/google.png"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3.2,
                            height: MediaQuery.of(context).size.width / 8,
                            decoration: BoxDecoration(
                                // color: Colors.deepOrangeAccent,

                                border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.circular(10)),
                            child: BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                if (state is AuthLoadingState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return InkWell(
                                      highlightColor: Colors.deepOrangeAccent
                                          .withOpacity(1),
                                      // splashColor: Colors.deepOrangeAccent.shade700,
                                      splashColor: Colors.deepOrangeAccent,
                                      onTap: () {
                                        authBlocSignUp.add(
                                            AuthSignUpEmailPasswordEvent(
                                                _usernameController.text,
                                                _passwordController.text));
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
                                              fontSize: 20),
                                        ),
                                      ));
                                }

                                // return CupertinoButton(
                                //     child: Text(
                                //       "Sign Up",
                                //       textAlign: TextAlign.center,
                                //       style: TextStyle(
                                //           color: Colors.white, fontSize: 15),
                                //     ),
                                //     onPressed: () {
                                //       authBlocSignUp.add(
                                //           AuthSignUpEmailPasswordEvent(
                                //               _usernameController.text,
                                //               _passwordController.text));
                                //     });
                              },
                            ),
                          ),
                        ],
                      )
                      // Container(
                      //   child: BlocBuilder<AuthBloc, AuthState>(
                      //     builder: (context, state) {
                      //       if (state is AuthLoadingState) {
                      //         return const Center(
                      //           child: CircularProgressIndicator(),
                      //         );
                      //       } else {
                      //         return CupertinoButton(
                      //             child: Text("Sign Up"),
                      //             onPressed: () {
                      //               authBlocSignUp.add(
                      //                   AuthSignUpEmailPasswordEvent(
                      //                       _usernameController.text,
                      //                       _passwordController.text));
                      //             });
                      //       }
                      //     },
                      //   ),
                      // ),
                      // Container(
                      //   // padding: EdgeInsets.all(),
                      //   width: MediaQuery.of(context).size.width / 3.2,
                      //   height: MediaQuery.of(context).size.width / 7,
                      //   decoration: BoxDecoration(
                      //       // color: Colors.deepOrangeAccent,
                      //       border: Border.all(color: Colors.blue.shade900),
                      //       borderRadius: BorderRadius.circular(10)),
                      //   child: InkWell(
                      //     highlightColor: Colors.blueGrey.withOpacity(1),
                      //     // splashColor: Colors.deepOrangeAccent.shade700,
                      //     splashColor: Colors.blueGrey,
                      //     onTap: () {
                      //       authBlocSignUp.add(AuthSignInGoogleEvent());
                      //     },
                      //     // customBorder: Border.all(color: Colors.amber),
                      //     borderRadius: BorderRadius.circular(10),
                      //     child: Container(
                      //       // alignment: Alignment.center,
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Image.asset("assets/images/google.png"),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // if (state is AuthLoadingState) {
                      //   return Center(
                      //     child: CircularProgressIndicator(),
                      //   );
                      // } else {
                      //   return CupertinoButton(
                      //       child: Text("Submit"),
                      //       onPressed: () {
                      //         bloc.add(AuthSignUpEmailPasswordEvent(
                      //             _usernameController.text,
                      //             _passwordController.text));
                      //       });
                    ],
                  );
                },
              ))),
    ));
  }
}
