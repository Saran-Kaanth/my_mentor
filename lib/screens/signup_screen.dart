import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';
import 'package:my_mentor/data/repositories/models/user.dart';

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
                    Navigator.pushNamedAndRemoveUntil(
                        context, "home", (route) => false);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Logged In Successfully"),
                      backgroundColor: Colors.deepOrangeAccent,
                    ));
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
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
                              hintText: "Username",
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
                      Container(
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return CupertinoButton(
                                  child: Text("Submit"),
                                  onPressed: () {
                                    authBlocSignUp.add(
                                        AuthSignUpEmailPasswordEvent(
                                            _usernameController.text,
                                            _passwordController.text));
                                  });
                            }
                          },
                        ),
                      )

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
