import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_mentor/blocs/postBloc/post_bloc.dart';
import 'package:my_mentor/blocs/profileBloc/profile_bloc.dart';
import 'package:my_mentor/blocs/searchBloc/search_bloc.dart';
// import 'package:my_mentor/screens/example_screen.dart';
import 'package:my_mentor/screens/home_screen.dart';
import 'package:my_mentor/screens/my_profile_screen.dart';
import 'package:my_mentor/screens/search_screen.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({Key? key}) : super(key: key);

  @override
  State<RouteScreen> createState() => RouteScreenState();
}

class RouteScreenState extends State<RouteScreen> {
  int _selectedIndex = 0;

  List<Widget> widgetOptions = [
    const HomeScreen(),
    // ExampleScreen(),
    SearchScreen(),
    MyProfileScreen()
  ];

  void onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final postBloc = BlocProvider.of<PostBloc>(context);
    return Scaffold(
      // backgroundColor: Colors.grey.shade900,
      body: IndexedStack(
        children: [
          Center(
            child: widgetOptions.elementAt(_selectedIndex),
          )
        ],
      ),
      bottomNavigationBar: bottomBar(),
    );
  }

  Widget bottomBar() {
    Size size = MediaQuery.of(context).size;
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    final postBloc = BlocProvider.of<PostBloc>(context);
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    return Container(
      // height: size.width / 4.5,
      // color: Colors.blueGrey.shade800,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.deepOrangeAccent),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: 1.1, horizontal: size.width / 90),
        child: GNav(
            padding: EdgeInsets.all(size.width / 20),
            gap: 4,
            // haptic: true,
            backgroundColor: Colors.grey.shade900,
            activeColor: Colors.deepOrangeAccent,
            color: Colors.blue.shade800,
            onTabChange: onItemTap,
            tabs: [
              GButton(
                icon: Icons.home_filled,
                text: "Home",
                onPressed: () {
                  postBloc.add(AllPostRetrieveEvent());
                },
              ),
              GButton(
                icon: Icons.search,
                text: "Search",
                onPressed: () {
                  searchBloc.add(InitialRecomEvent());
                },
              ),
              GButton(
                icon: Icons.account_circle_outlined,
                text: "Profile",
                onPressed: () {
                  profileBloc.add(ProfileLoadEvent());
                  postBloc.add(PostLoadingEvent());
                },
              )
            ]),
      ),
    );
  }
}
