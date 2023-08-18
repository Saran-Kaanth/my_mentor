import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';
import 'package:my_mentor/blocs/postBloc/post_bloc.dart';
// import 'package:my_mentor/data/repositories/profile_repository.dart';
import 'package:my_mentor/screens/my_profile_screen.dart';
import 'package:my_mentor/widgets.dart';
// import 'package:my_mentor/data/repositories/auth_repository.dart';
// import 'package:my_mentor/data/repositories/auth_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final bloc = BlocProvider.of<AuthBloc>(context);
    final User user = FirebaseAuth.instance.currentUser!;
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AllPostsRetrievingState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    spaceBox(20),
                    loadingWidget(loadingWidgetColor: Colors.deepOrangeAccent),
                    spaceBox(20),
                    textValueWidget("Hang on ...",
                        fontSize: 25, textColor: Colors.blue)
                  ],
                ),
              );
            } else if (state is AllPostsRetreivedState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        textValueWidget("Hey",
                            textColor: Colors.blue, fontSize: 25),
                        SizedBox(
                          width: 5,
                        ),
                        textValueWidget(user.displayName!, fontSize: 25)
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.allPostsList!.length,
                    physics: NeverScrollableScrollPhysics(),
                    // physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      // var authorImgName = ProfileRepository().retrieveAuthorImgName(
                      //     state.allPostsList![index].authorId!);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          tileColor: Colors.grey.shade900,
                          title: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.deepOrangeAccent,
                                radius: 17,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textValueWidget(
                                      state.allPostsList![index].postedBy
                                          .toString(),
                                      fontSize: 15),
                                  textValueWidget(
                                      state.allPostsList![index].postDate
                                          .toString(),
                                      textColor: Colors.grey.shade500)
                                ],
                              ),
                            ],
                          ),
                          subtitle: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                spaceBox(8),
                                Center(
                                  child: Card(
                                    color: Colors.white,
                                    child: Image.network(state
                                        .allPostsList![index].postUrl
                                        .toString()),
                                  ),
                                ),
                                // spaceBox(10),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      state.allPostsList![index].postDescription
                                          .toString(),
                                      maxLines: null,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    ));
  }
}

// child: BlocConsumer<AuthBloc, AuthState>(
//           listener: (context, state) {
//             if (state is AuthLoggedOutState) {
//               Navigator.pushNamedAndRemoveUntil(
//                   context, "login", (route) => false);
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: Text("Logged Out Successfully"),
//                 backgroundColor: Colors.deepOrangeAccent,
//               ));
//             }
//           },
//           builder: (context, state) {
//             print("The originial state");
//             print(state.toString());
//             if (state is AuthLoggedInState) {
//               return Column(
//                 children: [
//                   Text(
//                     user.email.toString(),
//                     style: TextStyle(color: Colors.deepOrangeAccent),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   CupertinoButton(
//                       child: Text(
//                         "Sign out",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () {
//                         bloc.add(AuthSignOutEvent());
//                       }),
//                 ],
//               );
//             } else {
//               return Center(
//                 child: Column(
//                   children: [
//                     Text("Please Log in Again"),
//                     ElevatedButton(
//                         onPressed: () {
//                           Navigator.pushNamedAndRemoveUntil(
//                               context, "login", (route) => false);
//                         },
//                         child: Text("log In"))
//                   ],
//                 ),
//               );
//             }
//             // return Container();
//           },
//         )
