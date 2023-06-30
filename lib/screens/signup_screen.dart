import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController? _usernameController = TextEditingController();
  TextEditingController? _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthBloc>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
          height: size.height / 2,
          width: size.width / 1.5,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          // color: Colors.amberAccent,
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: "Username"),
                style: TextStyle(color: Colors.white),
                controller: _usernameController,
              ),
              TextField(
                decoration: InputDecoration(hintText: "password"),
                style: TextStyle(color: Colors.white),
                controller: _passwordController,
              ),
              BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
                if (state is AuthLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return CupertinoButton(
                      child: Text("Submit"),
                      onPressed: () {
                        bloc.add(AuthSignUpEmailPasswordEvent(
                            _usernameController!.text,
                            _passwordController!.text));
                        // bloc.add(AuthDataSubmittedEvent(
                        //     _usernameController!.text,
                        //     _passwordController!.text));
                      });
                }
              }, listener: (context, state) {
                if (state is AuthLoggedInState) {
                  Navigator.pushNamed(context, "home");
                }
              }),
            ],
          ),
        ),
      )),
    );
  }
}
