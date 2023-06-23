import 'package:flutter/material.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Welcome"),
        //   centerTitle: true,
        // ),
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.start,
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
                        height: MediaQuery.of(context).size.height / 1.6,
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
                    // width: 50,
                    // height: 50,
                    // alignment: Alignment.bottomCenter,
                    // padding:
                    // EdgeInsets.all(MediaQuery.of(context).size.height / 3),
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

          // decoration: BoxDecoration(
          //     gradient: LinearGradient(colors: [
          //   Colors.indigo.shade200,
          //   Colors.yellowAccent.shade100,
          //   Colors.grey.shade700
          // ])),
          Flexible(
            child: Container(
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: GoogleFonts.mavenPro(
                        fontSize: 40,
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
              child: Container(
            // width: MediaQuery.of(context).size.width / 1.2,
            // padding: EdgeInsets.all(MediaQuery.of(context).size.width),
            child: Column(
              children: [
                TextField(
                    // style: TextStyle(height: 0.1),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ))
              ],
            ),
          ))
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
