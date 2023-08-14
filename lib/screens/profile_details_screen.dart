import 'dart:io';
import 'dart:typed_data';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_controller/form_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_mentor/blocs/profileBloc/profile_bloc.dart';
import 'package:my_mentor/data/models/user.dart';
import 'package:my_mentor/data/repositories/profile_repository.dart';
import 'package:my_mentor/screens/my_profile_screen.dart';
import 'package:my_mentor/utils.dart';
import 'package:my_mentor/widgets.dart';
import 'package:select_form_field/select_form_field.dart';
// import 'package:pinput/pinput.dart';

class ProfileDetailsScreen extends StatelessWidget {
  final UserProfileDetailsModel? userProfileDetailsModel;
  bool first = false;
  ProfileDetailsScreen(
      {super.key, required this.userProfileDetailsModel, required this.first});
  FormController formController = FormController();
  Uint8List? image;
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  // User user = FirebaseAuth.instance.currentUser!;

  void dispose() {
    formController.dispose();
  }

  selectImage() async {
    return await pickImage(ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    final Reference storageRef = FirebaseStorage.instance.ref();
    final User user = FirebaseAuth.instance.currentUser!;
    Size size = MediaQuery.of(context).size;
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    final List<Map<String, dynamic>> isMentorOptions = [
      {'value': 'true', 'label': 'Yes'},
      {'value': 'false', 'label': 'No'}
    ];
    int counter = 0;
    print("counter $counter.toString()");
    formController.controller("displayName").text =
        userProfileDetailsModel!.displayName == null
            ? ""
            : userProfileDetailsModel!.displayName.toString();
    formController.controller("fullName").text =
        userProfileDetailsModel!.fullName == null
            ? ""
            : userProfileDetailsModel!.fullName.toString();
    formController.controller("dob").text = userProfileDetailsModel!.dob == null
        ? ""
        : userProfileDetailsModel!.dob.toString();
    formController.controller("photoUrl").text =
        userProfileDetailsModel!.photoUrl == null
            ? ""
            : userProfileDetailsModel!.photoUrl.toString();
    formController.controller("occupation").text =
        userProfileDetailsModel!.occupation == null
            ? ""
            : userProfileDetailsModel!.occupation.toString();
    formController.controller("headline").text =
        userProfileDetailsModel!.headline == null
            ? ""
            : userProfileDetailsModel!.headline.toString();
    formController.controller("city").text =
        userProfileDetailsModel!.city == null
            ? ""
            : userProfileDetailsModel!.city.toString();
    formController.controller("state").text =
        userProfileDetailsModel!.state == null
            ? ""
            : userProfileDetailsModel!.state.toString();
    formController.controller("country").text =
        userProfileDetailsModel!.country == null
            ? ""
            : userProfileDetailsModel!.country.toString();
    formController.controller("phone").text =
        userProfileDetailsModel!.phone == null
            ? ""
            : userProfileDetailsModel!.phone.toString();
    formController.controller("skills").text =
        userProfileDetailsModel!.skills == null
            ? ""
            : userProfileDetailsModel!.skills!.join(",").toString();
    formController.controller("isMentor").text =
        userProfileDetailsModel!.isMentor.toString();
    country.text = userProfileDetailsModel!.country.toString();

    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(size.width / 45),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: size.height / 7.6,
                    width: size.width / 1.46,
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                first ? "Setup" : "Edit",
                                style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w100),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Your Profile",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 33,
                                    fontWeight: FontWeight.w100),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
                Stack(alignment: Alignment(2.5, 4.6), children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: userProfileDetailsModel!.photoUrl == null
                        ? null
                        : NetworkImage(
                            userProfileDetailsModel!.photoUrl.toString()),
                  ),
                  IconButton(
                      onPressed: () async {
                        counter++;
                        print(counter);

                        String filePath = await selectImage();
                        String uniquleFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        if (filePath != "") {
                          try {
                            Reference imageUploadRef = storageRef
                                .child("images")
                                .child(user.uid.toString())
                                .child(uniquleFileName);
                            await imageUploadRef.putFile(File(filePath));

                            print("file saved");

                            userProfileDetailsModel!.photoUrl =
                                await imageUploadRef.getDownloadURL();
                          } catch (e) {
                            print(e.toString());
                          }
                        }
                      },
                      splashColor: Colors.transparent,
                      splashRadius: 5,
                      icon: Icon(
                        Icons.camera_alt_rounded,
                        size: 15,
                      ))
                ]),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Form(
              key: formController.key,
              child: Padding(
                padding: EdgeInsets.only(
                    left: size.width / 23, right: size.width / 23),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      //// style: TextStyle(color: Colors.white),
                      controller: formController.controller("displayName"),
                      onChanged: (value) {
                        userProfileDetailsModel!.displayName = value.toString();
                      },
                      onSaved: (newValue) =>
                          userProfileDetailsModel!.displayName = newValue,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Your display name";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Display Name",
                          prefixIcon: Icon(Icons.accessibility_outlined)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      // style: TextStyle(color: Colors.white),
                      controller: formController.controller("fullName"),
                      onChanged: (value) =>
                          userProfileDetailsModel!.fullName = value,
                      onSaved: (newValue) =>
                          userProfileDetailsModel!.fullName = newValue,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Your Full Name";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Full Name",
                          prefixIcon: Icon(Icons.perm_identity_outlined)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    DateTimeFormField(
                      // dateTextStyle: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.blue),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        // border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.event_note),
                        labelText: 'Birth Date',
                      ),
                      mode: DateTimeFieldPickerMode.date,
                      autovalidateMode: AutovalidateMode.always,
                      onSaved: (newValue) {
                        // userProfileDetailsModel!.dob = dateFormat.format(newValue.);

                        print(userProfileDetailsModel!.dob);
                      },
                      onDateSelected: (DateTime value) {
                        userProfileDetailsModel!.dob = dateFormat.format(value);
                        print(userProfileDetailsModel!.dob);
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      // style: TextStyle(color: Colors.white),
                      controller: formController.controller("occupation"),
                      onSaved: (newValue) =>
                          userProfileDetailsModel!.occupation = newValue,
                      onChanged: (value) =>
                          userProfileDetailsModel!.occupation = value,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Your Occupation";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Occupation",
                          prefixIcon: Icon(Icons.local_library_outlined)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      // maxLines: 3,
                      // expands: true,
                      // style: TextStyle(color: Colors.white),
                      controller: formController.controller("headline"),
                      onChanged: (value) =>
                          userProfileDetailsModel!.headline = value,
                      onSaved: (newValue) =>
                          userProfileDetailsModel!.headline = newValue,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Give short info of u..";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: "About Yourself",
                          prefixIcon: Icon(Icons.info_outline)),
                    ),
                    TextFormField(
                      // style: TextStyle(color: Colors.white),
                      controller: formController.controller("city"),
                      onSaved: (newValue) =>
                          userProfileDetailsModel!.city = newValue,
                      onChanged: (value) =>
                          userProfileDetailsModel!.city = value,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Your City";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: "City",
                          prefixIcon: Icon(Icons.location_on_outlined)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      // style: TextStyle(color: Colors.white),
                      controller: formController.controller("state"),
                      onChanged: (value) =>
                          userProfileDetailsModel!.state = value,
                      onSaved: (newValue) =>
                          userProfileDetailsModel!.state = newValue,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Your State";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: "State",
                          prefixIcon: Icon(Icons.location_city_outlined)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // SelectState(
                    //     dropdownColor: Colors.grey.shade300,
                    //    // style: TextStyle(color: Colors.white),
                    //     onCountryChanged: (value) {
                    //       print(value);
                    //     },
                    //     onStateChanged: (value) {
                    //       print(value);
                    //     },
                    //     onCityChanged: (value) {
                    //       print(value);
                    //     }),
                    // CountryStateCityPicker(
                    //   country: formController.controller("country"),
                    //   // state: formController.controller("state"),
                    //   // city: formController.controller("city"),
                    //   // country: country,
                    //   state: state,
                    //   city: city,
                    //   textFieldDecoration: InputDecoration(
                    //     icon: Icon(Icons.location_on_outlined),
                    //   ),
                    //   dialogColor: Colors.grey.shade500,
                    // ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      // style: TextStyle(color: Colors.white),
                      controller: formController.controller("country"),
                      onChanged: (value) =>
                          userProfileDetailsModel!.country = value,
                      onSaved: (newValue) =>
                          userProfileDetailsModel!.country = newValue,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Your Country";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Country",
                          prefixIcon: Icon(Icons.location_city_outlined)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      // style: TextStyle(color: Colors.white),
                      controller: formController.controller("phone"),
                      onChanged: (value) =>
                          userProfileDetailsModel!.phone = value,
                      onSaved: (newValue) =>
                          userProfileDetailsModel!.phone = newValue,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Your Mobile No.";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Mobile",
                          prefixIcon: Icon(Icons.phone_android_outlined)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      // style: TextStyle(color: Colors.white),
                      controller: formController.controller("skills"),
                      onChanged: (value) =>
                          userProfileDetailsModel!.skills = skillsToList(value),
                      onSaved: (newValue) => userProfileDetailsModel!.skills =
                          skillsToList(newValue!),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "One skill is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Skills",
                          prefixIcon: Icon(Icons.grade_outlined),
                          helperText: "use (,)"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SelectFormField(
                      // style: TextStyle(color: Colors.white),
                      // initialValue: ,
                      icon: Icon(Icons.work_outlined),
                      controller: formController.controller("isMentor"),
                      // icon: Icon(Icons.format_shapes),
                      labelText: 'Are you a mentor?',
                      items: isMentorOptions,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Choose Your Option";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        userProfileDetailsModel!.isMentor = toBoolean(value);
                      },
                      onSaved: (newValue) {
                        userProfileDetailsModel!.isMentor =
                            toBoolean(newValue!);
                      },
                    ),
                    BlocConsumer<ProfileBloc, ProfileState>(
                      listener: (context, state) {
                        if (state is ProfileUpdatedState) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, "route", (route) => false);
                        }
                      },
                      builder: (context, state) {
                        if (state is ProfileUpdatingState) {
                          return loadingWidget();
                        } else if (state is ProfileErrorState) {
                          return Center(
                            child: textValueWidget(state.errorMessage,
                                fontSize: 20),
                          );
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            first
                                ? Container()
                                : CupertinoButton(
                                    child: Container(
                                      child: Center(
                                        child: Icon(
                                          Icons.cancel,
                                          size: 40,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                            CupertinoButton(
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 40,
                                ),
                                onPressed: () async {
                                  print(country.value);
                                  print(formController.controller("city").text);
                                  if (!formController.key.currentState!
                                      .validate()) {
                                    return;
                                  }
                                  formController.key.currentState!.save();
                                  // print(country.value);
                                  // userProfileDetailsModel!.country =
                                  //     formController.controller("country").text;
                                  // userProfileDetailsModel!.state =
                                  //     formController.controller("state").text;
                                  // userProfileDetailsModel!.city =
                                  //     formController.controller("city").text;

                                  profileBloc.add(ProfileUpdateEvent(
                                      userProfileDetailsModel!));
                                })
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    ));
  }
}

bool toBoolean(String value) {
  if (value == 'true') {
    return true;
  } else {
    return false;
  }
}

List skillsToList(String value) {
  print(value);
  print(value.split(","));
  return value.split(",");
}



//  Container(
                        // height: size.height / 9.4,
                        // width: size.width / 4.2,
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.blue),
                        //     borderRadius: BorderRadius.circular(50)),
