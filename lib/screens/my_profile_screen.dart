import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';
import 'package:my_mentor/blocs/postBloc/post_bloc.dart';
import 'package:my_mentor/blocs/profileBloc/profile_bloc.dart';
import 'package:my_mentor/data/repositories/models/user.dart';
import 'package:my_mentor/data/repositories/profile_repository.dart';
import 'package:switch_tab/switch_tab.dart';

class MyProfileScreen extends StatefulWidget {
  MyProfileScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MyProfileScreenState();
}

class MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    final DatabaseReference dbRef =
        FirebaseDatabase.instance.ref("profileDetails");
    // late UserProfileDetailsModel profileData;
    // List<Widget> indexedWidgets = [profileWidget()];
    List<Widget> indexedWidgets = [profileWidget(), postWidget()];
    Size size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<AuthBloc>(context);
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    final postBloc = BlocProvider.of<PostBloc>(context);
    int selectedIndex = 0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {},
              builder: (context, state) {
                try {
                  if (state is ProfileLoadingState) {
                    return Center(child: loadingWidget());
                  }
                  // return Container();
                } catch (e) {
                  return Text("Please try again!");
                }
                return BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoadedState) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: size.height / 13,
                            // color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Profile",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.blue),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        bloc.add(AuthSignOutEvent());
                                      },
                                      icon: Icon(
                                        Icons.output_sharp,
                                        size: 25,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            // decoration: BoxDecoration(
                            //     border:
                            //         Border.all(color: Colors.deepOrangeAccent)),
                            // padding: EdgeInsets.all(size.width / ),
                            width: size.width,
                            // height: size.height / 6,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Container(
                                                child: CircleAvatar(
                                                    radius: 40,
                                                    // maxRadius: 38,
                                                    backgroundColor:
                                                        Colors.deepOrangeAccent,
                                                    child: CircleAvatar(
                                                      radius: 38,
                                                      backgroundImage:
                                                          NetworkImage(state
                                                              .userProfileDetailsModel!
                                                              .photoUrl
                                                              .toString()),
                                                    )),
                                              ),
                                              (state.userProfileDetailsModel!
                                                          .isMentor ==
                                                      true)
                                                  ? Icon(
                                                      Icons.work_outlined,
                                                      color: Colors
                                                          .amberAccent.shade200,
                                                      size: 20,
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0),
                                            child: CupertinoButton(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Edit Profile",
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Icon(
                                                      Icons.edit,
                                                      size: 15,
                                                    )
                                                  ],
                                                ),
                                                onPressed: () {}),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Column(
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            // height: 60,
                                            width: size.width / 1.5,
                                            child: Text(
                                              state.userProfileDetailsModel!
                                                  .displayName
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.visible,
                                              // softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.grey.shade300,
                                                  fontSize: 22),
                                            ),
                                          ),
                                          Container(
                                            // height: 60,
                                            width: size.width / 1.5,
                                            child: Text(
                                              state.userProfileDetailsModel!
                                                  .fullName
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.visible,
                                              // softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.grey.shade400,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          Container(
                                            // height: 60,
                                            width: size.width / 1.5,
                                            child: Text(
                                              state.userProfileDetailsModel!
                                                  .headline
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.visible,
                                              // softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.grey.shade400,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          Container(
                                            // height: 60,
                                            width: size.width / 1.5,
                                            child: Text(
                                              state.userProfileDetailsModel!
                                                      .state
                                                      .toString() +
                                                  "," +
                                                  state.userProfileDetailsModel!
                                                      .country
                                                      .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.visible,
                                              // softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.grey.shade400,
                                                  fontSize: 17),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: size.width,
                            height: 50,
                            color: Colors.black,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () => setState(() {
                                    selectedIndex = 0;
                                  }),
                                  child: Text(
                                    "About",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => setState(() {
                                    selectedIndex = 1;
                                  }),
                                  child: Text(
                                    "Posts",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => setState(() {
                                    selectedIndex = 2;
                                  }),
                                  child: Text(
                                    "Settings",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Container(
                          //   child: SwitchTab(
                          //       onValueChanged: (value) {
                          //         print(value);
                          //         setState(() {
                          //           selectedIndex = value;
                          //         });
                          //       },
                          //       text: ["About", "Posts"]),
                          // ),
                          // Container(
                          //   color: Colors.amber,
                          //   child: GNav(
                          //       padding: EdgeInsets.all(size.width / 20),
                          //       gap: 4,
                          //       backgroundColor: Colors.grey.shade900,
                          //       activeColor: Colors.white,
                          //       color: Colors.grey.shade700,
                          //       onTabChange: (value) {
                          //         setState(() {
                          //           selectedIndex = value;
                          //         });
                          //       },
                          //       tabs: [
                          //         GButton(
                          //           icon: Icons.info_outline,
                          //           text: "About",
                          //         ),
                          //         GButton(
                          //           icon: Icons.image_outlined,
                          //           text: "Posts",
                          //           onPressed: () {
                          //             postBloc.add(PostLoadingEvent());
                          //           },
                          //         ),
                          //         GButton(
                          //           icon: Icons.settings,
                          //           text: "Settings",
                          //         ),
                          //       ]),
                          // ),
                          Container(
                            child: indexedWidgets.elementAt(selectedIndex),
                          )
                        ],
                      );
                    }
                    return Container();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget profileWidget() {
    return Center(
      child: Text("Hello Profile"),
    );
    // return BlocBuilder<ProfileBloc, ProfileState>(
    //   builder: (context, state) {
    //     if (state is ProfileLoadedState) {
    //       return Center(
    //           child: Text(
    //         "Profile Page",
    //         style: TextStyle(color: Colors.white),
    //       ));
    //     }
    //     return Container();
    //   },
    // );
  }

  Widget postWidget() {
    return Center(
      child: Text("Hello Post"),
    );
    // return BlocBuilder<PostBloc, PostState>(
    //   builder: (context, state) {
    //     if (state is PostLoadedState) {
    //       return Center(
    //           child: Text(
    //         "Post Page",
    //         style: TextStyle(color: Colors.white),
    //       ));
    //     }
    //     return Container();
    //   },
    // );
  }

  Widget loadingWidget() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
