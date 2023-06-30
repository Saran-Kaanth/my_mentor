import 'package:flutter/material.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                        fontSize: 35,
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Flexible(
              child: SizedBox(
            height: size.height / 4.5,
            child: Container(
              height: MediaQuery.of(context).size.height / 4.5,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrangeAccent),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        // textAlign: TextAlign.center,
                        // textAlignVertical: TextAlignVertical.top,
                        style: TextStyle(color: Colors.amber),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle_rounded),
                            contentPadding: EdgeInsets.only(bottom: 2, left: 5),
                            hintText: "Username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.lightGreenAccent))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 50,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        // textAlign: TextAlign.center,
                        // textAlignVertical: TextAlignVertical.top,
                        style: TextStyle(color: Colors.amber),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.key_rounded),
                            contentPadding: EdgeInsets.only(bottom: 2, left: 5),
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.lightGreenAccent))),
                      ),
                    ),
                  ),
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
                                // gradient: LinearGradient(colors: [
                                //   Colors.white,
                                //   Colors.indigo.shade400
                                // ]),
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              highlightColor: Colors.blueGrey.withOpacity(1),
                              // splashColor: Colors.deepOrangeAccent.shade700,
                              splashColor: Colors.blueGrey,
                              onTap: () {},
                              // customBorder: Border.all(color: Colors.amber),
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/google.png"),
                                    // Text(
                                    //   // "Google",""
                                    //   "",
                                    //   style: GoogleFonts.mavenPro(
                                    //       color: Colors.white,
                                    //       // fontWeight: FontWeight.w400,
                                    //       fontSize: 20),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
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
                              onTap: () {},
                              // customBorder: Border.all(color: Colors.amber),
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                alignment: Alignment.center,
                                child:
                                    // mainAxisSize: MainAxisSize.min,

                                    Text(
                                  "Login",
                                  style: GoogleFonts.mavenPro(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.w400,
                                      fontSize: 23),
                                ),
                                // Icon(
                                //   Icons.arrow_forward_ios_rounded,
                                //   size: 20,
                                // ),
                              ),
                            ),
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
                        // gradient: LinearGradient(colors: [
                        //   Colors.white,
                        //   Colors.indigo.shade400
                        // ]),
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
                        child:
                            // mainAxisSize: MainAxisSize.min,

                            Text(
                          "Sign Up",
                          style: GoogleFonts.mavenPro(
                              color: Colors.white,
                              // fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                        // Icon(
                        //   Icons.arrow_forward_ios_rounded,
                        //   size: 20,
                        // ),
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
