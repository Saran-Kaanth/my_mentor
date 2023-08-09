import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';
import 'package:my_mentor/blocs/postBloc/post_bloc.dart';
import 'package:my_mentor/blocs/profileBloc/profile_bloc.dart';
// import 'package:my_mentor/data/repositories/auth_repository.dart';
import 'package:my_mentor/screens/post_add_screen.dart';
import 'package:my_mentor/screens/profile_details_screen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MyProfileScreenState();
}

class MyProfileScreenState extends State<MyProfileScreen>
    with TickerProviderStateMixin {
  // late TabController tabController;
  //  TabController tabController=TabController(length: 3, vsync: this);
  User user = FirebaseAuth.instance.currentUser!;
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref("profileDetails");
  CroppedFile? imageFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // tabController.dispose();
    super.dispose();
  }

  void chooseImage(ImageSource source) async {
    // final ImagePicker imagePicker=ImagePicker();
    XFile? pickedFile = await ImagePicker()
        .pickImage(source: source, maxHeight: 1080, maxWidth: 1080);
    cropImage(pickedFile!.path);
  }

  void cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (croppedImage != null) {
      setState(() {
        imageFile = croppedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<AuthBloc>(context);
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    final postBloc = BlocProvider.of<PostBloc>(context);
    TabController tabController = TabController(length: 3, vsync: this);
    // final TabController tabController = DefaultTabController.of(context);

    return Scaffold(
      body: SafeArea(
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
                                style:
                                    TextStyle(fontSize: 30, color: Colors.blue),
                              ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: 2,
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                  backgroundImage: NetworkImage(
                                                      state
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
                                        padding:
                                            EdgeInsets.symmetric(vertical: 0),
                                        child: CupertinoButton(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Edit Profile",
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                SizedBox(width: 5),
                                                Icon(
                                                  Icons.edit,
                                                  size: 15,
                                                )
                                              ],
                                            ),
                                            onPressed: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfileDetailsScreen(
                                                            userProfileDetailsModel:
                                                                state
                                                                    .userProfileDetailsModel,
                                                            first: false,
                                                          )));
                                              // await user
                                              //     .updateDisplayName("Saran K");
                                              // await dbRef
                                              //     .orderByChild("displayName")
                                              //     .equalTo("Saran ")
                                              //     .get()
                                              //     .then((value) =>
                                              //         print(value.value))
                                              //     .onError((error,
                                              //             stackTrace) =>
                                              //         print(error.toString()));
                                            }),
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
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                          state
                                              .userProfileDetailsModel!.fullName
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
                                          state
                                              .userProfileDetailsModel!.headline
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
                                          state.userProfileDetailsModel!.state
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
                      TabBar(
                          // isScrollable: true,
                          labelStyle: GoogleFonts.mavenPro(),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.deepOrangeAccent[100],
                          controller: tabController,
                          tabs: [
                            Tab(
                              text: "Info",
                              icon: Icon(Icons.info),
                            ),
                            Tab(
                              text: "Posts",
                              icon: Icon(Icons.image),
                            ),
                            Tab(
                              text: "Settings",
                              icon: Icon(Icons.settings),
                            )
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: TabBarView(
                        controller: tabController,
                        children: [
                          profileWidget(size),
                          postWidget(size),
                          settingsWidget(size, bloc)
                        ],
                      ))
                    ],
                  );
                }
                return Container();
              },
            );
          },
        ),
      ),
    );
  }

  Widget profileWidget(Size size) {
    try {
      return SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadedState) {
              return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.width / 18,
                    horizontal: size.width / 25,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textSubHeadWidget("Skills"),
                      spaceBox(5),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount:
                            state.userProfileDetailsModel!.skills!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 7,
                                mainAxisExtent: 50,
                                childAspectRatio: 3.5),
                        itemBuilder: (context, index) {
                          return Container(
                            // height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.deepOrangeAccent)),
                            // color: Colors.grey.shade700,

                            child: Center(
                              child: Text(
                                state.userProfileDetailsModel!.skills![index],
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                      spaceBox(15),
                      textSubHeadWidget("Date of Birth"),
                      spaceBox(5),
                      textValueWidget(state.userProfileDetailsModel!.dob == null
                          ? "NA"
                          : state.userProfileDetailsModel!.dob.toString()),
                      spaceBox(15),
                      textSubHeadWidget("Email"),
                      spaceBox(5),
                      textValueWidget(state.userProfileDetailsModel!.email ==
                              null
                          ? "NA"
                          : state.userProfileDetailsModel!.email.toString()),
                      spaceBox(15),
                      textSubHeadWidget("Contact"),
                      spaceBox(5),
                      textValueWidget(state.userProfileDetailsModel!.phone ==
                              null
                          ? "NA"
                          : "+91" +
                              state.userProfileDetailsModel!.phone.toString()),
                      spaceBox(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                state.userProfileDetailsModel!.connections
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontSize: 40),
                              ),
                              Text(
                                "Connections",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 20),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ));
            } else if (state is ProfileLoadingState) {
              return loadingWidget();
            } else if (state is ProfileErrorState) {
              return Center(
                child: Text(
                  state.errorMessage.toString(),
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
            return Container();
          },
        ),
      );
    } catch (e) {
      return Container(child: errorWidget());
    }
  }

  Widget postWidget(Size size) {
    try {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.width / 18,
            horizontal: size.width / 25,
          ),
          child: Stack(
            alignment: Alignment(1, 1),
            // alignment: Alignment.bottomRight,
            // clipBehavior: Clip.antiAlias,
            // fit: StackFit.passthrough,
            children: [
              BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is PostLoadedState) {
                    if (state.myPostsList == null ||
                        state.myPostsList!.isEmpty) {
                      return Center(
                        child: Text(
                          "No Posts Yet!",
                          style: TextStyle(
                              fontSize: 20, color: Colors.deepOrangeAccent),
                        ),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: state.myPostsList!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 7,
                                  childAspectRatio: 0.9),
                          itemBuilder: (context, index) {
                            print(state.myPostsList![index]!.authorId);
                            return InkWell(
                              onTap: () {
                                print(
                                    state.myPostsList![index]!.postDescription);
                                fullImage(
                                    state.myPostsList![index]!.postUrl!,
                                    state.myPostsList![index]!.postDescription!,
                                    context,
                                    size);
                              },
                              child: Container(
                                color: Colors.grey.shade600,
                                child: Image.network(state
                                    .myPostsList![index]!.postUrl
                                    .toString()),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                  return Container();
                },
              ),
              Positioned(
                child: FloatingActionButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PostAddScreen(),
                        ));
                  },
                  child: Container(
                    child: Icon(
                      Icons.add,
                      size: 50,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } catch (e) {
      print("hello");
      print(e.toString());
      return Container(
        child: errorWidget(),
      );
      // errorWidget();
    }
  }

  Widget settingsWidget(Size size, Bloc bloc) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: size.width / 18,
          horizontal: size.width / 25,
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                bloc.add(AuthSignOutEvent());
              },
              splashColor: Colors.red,
              child: Container(
                width: size.width,
                height: 50,
                // color: Colors.grey.shade700,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: Colors.deepOrangeAccent)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        size: 30,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      textValueWidget("Logout", fontSize: 25)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  fullImage(String imgSrc, String postDescription, context, Size size) {
    return showDialog(
      context: context,
      barrierLabel: "Hello",
      builder: (context) {
        return Dialog(
          alignment: Alignment.topCenter,
          // backgroundColor: Colors.white,
          child: Container(
            height: size.height / 2,
            width: size.height / 1.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                spaceBox(25),
                Container(
                    height: size.height / 4,
                    width: size.width,
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    color: Colors.grey.shade700,
                    child: Image.network(imgSrc)),
                spaceBox(20),
                textValueWidget(postDescription, fontSize: 20)
                // Text(
                //   postDescription,
                //   textAlign: TextAlign.left,
                // )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget loadingWidget() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}

Widget errorWidget() {
  return Center(
    child: Text("Please try again"),
  );
}

Text textSubHeadWidget(String textValue) {
  return Text(
    textValue,
    style: TextStyle(color: Colors.blue.shade400, fontSize: 18),
  );
}

Text textValueWidget(String textValue,
    {double fontSize = 15, Color textColor = Colors.grey}) {
  return Text(
    textValue,
    style: TextStyle(
        color: textColor == Colors.grey ? Colors.grey.shade300 : textColor,
        fontSize: fontSize),
  );
}

SizedBox spaceBox(double height) {
  return SizedBox(
    height: height,
  );
}


// ---------------------
// Container(
//   width: size.width,
//   height: 50,
//   color: Colors.black,
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       InkWell(
//         onTap: () => setState(() {
//           selectedIndex = 0;
//         }),
//         child: Text(
//           "About",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       InkWell(
//         onTap: () => setState(() {
//           selectedIndex = 1;
//         }),
//         child: Text(
//           "Posts",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       InkWell(
//         onTap: () => setState(() {
//           selectedIndex = 2;
//         }),
//         child: Text(
//           "Settings",
//           style: TextStyle(color: Colors.white),
//         ),
//       )
//     ],
//   ),
// ),
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
// Container(
//   child: indexedWidgets.elementAt(selectedIndex),
// )
