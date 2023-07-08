import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';
// import 'package:my_mentor/data/repositories/auth_repository.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthBloc>(context);
    final User user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoggedOutState) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "login", (route) => false);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Logged Out Successfully"),
                backgroundColor: Colors.deepOrangeAccent,
              ));
            }
          },
          builder: (context, state) {
            if (state is AuthLoggedInState) {
              return Column(
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
                        bloc.add(AuthSignOutEvent());
                      })
                ],
              );
            } else {
              return Container(
                child: Center(child: Text("Please Log in Again")),
              );
            }
          },
        )),
      ),
    );
  }
}
