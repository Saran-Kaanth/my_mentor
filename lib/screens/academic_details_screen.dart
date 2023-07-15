// // import 'dart:developer';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert' as convert;
// import 'package:http/http.dart' as http;
// import 'package:firebase_database/firebase_database.dart';
// import 'package:intl/intl.dart';

// class AcademicDetailsScreen extends StatefulWidget {
//   @override
//   AcademicDetailsScreenState createState() => AcademicDetailsScreenState();
// }

// class AcademicDetailsScreenState extends State<AcademicDetailsScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _nameController;
//   static List<String> foodsList = [""];
//   late List<Map<dynamic, dynamic>> foodDetails;
//   late DatabaseReference _ref;
//   bool state = false;
//   late String msg;
//   FirebaseAuth _instance = FirebaseAuth.instance;
//   var avgCalories = "";
//   var avgProtein = "";
//   var avgFat = "";
//   var avgCholes = "";
//   var avgCarbs = "";
//   Map _avgData = {};
//   List months = [
//     'Jan',
//     'Feb',
//     'Mar',
//     'Apr',
//     'may',
//     'jun',
//     'jul',
//     'aug',
//     'sep',
//     'oct',
//     'nov',
//     'dec'
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//     _ref = FirebaseDatabase.instance.ref("users");
//     msg = "Processing";
//     _nameController.clear();
//     _ref
//         .child(_instance.currentUser!.uid)
//         .child("all_data")
//         .child("avg")
//         .child(months[(DateTime.now().month) - 1])
//         .once()
//         .then((value) {
//       if (value.snapshot.value != null) {
//         _avgData = value.snapshot.value as Map;
//         print(_avgData);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     super.dispose();
//   }

//   // var client = http.Client();
//   Future<Map<dynamic, dynamic>> main(String _reqBody) async {
//     Future.delayed(Duration(milliseconds: 1));
//     var queryParameters = {
//       'query': _reqBody,
//     };

//     var headers = {'x-api-key': '7VSkbFyyllYBIKwvFsEa5A==U0b9u9ct9A209r0Y'};

//     var url =
//         Uri.https('api.calorieninjas.com', '/v1/nutrition', queryParameters);

//     var response = await http.get(url, headers: headers);

//     if (response.statusCode == 200) {
//       final jsonResponse = convert.jsonDecode(response.body);
//       final foodVal = jsonResponse as Map;
//       return foodVal;
//     }
//     return {};
//   }

//   getHealthDetails() async {
//     // FirebaseAuth _instance = FirebaseAuth.instance;
//     DateFormat dateFormat_1 = DateFormat("yyyy-MM-dd");
//     DateFormat dateFormat_2 = DateFormat("hh:mm:ss");

//     print(months[(DateTime.now().month) - 1]);
//     int len = foodsList.length;
//     int ori_len = len - 1;
//     print(ori_len);
//     var total_cal = 0.0;
//     var total_protein = 0.0;
//     var total_fat = 0.0;
//     var total_cholesterol = 0.0;
//     var total_sugar = 0.0;
//     var total_carbs = 0.0;
//     Map foodNutrData = {};
//     while (ori_len >= 0) {
//       Map<dynamic, dynamic> value = await main(foodsList[ori_len]);
//       print(value["items"].isEmpty);

//       print(value["items"]);
//       if (!value["items"].isEmpty) {
//         var foodData = value["items"][0];
//         // print(value["items"][0]["calories"].runtimeType);
//         total_cal += foodData["calories"];
//         total_sugar += foodData["sugar_g"];
//         total_protein += foodData["protein_g"];
//         total_carbs += foodData["carbohydrates_total_g"];
//         total_fat += foodData["fat_total_g"];
//         total_cholesterol += foodData["cholesterol_mg"];
//         foodNutrData[foodData["name"]] = foodData;
//       }
//       foodNutrData["total_nutrients"] = {
//         "total_cal_g": total_cal,
//         "total_sugar_g": total_sugar,
//         "total_protein_g": total_protein,
//         "total_carbs_g": total_carbs,
//         "total_fat_g": total_fat,
//         "total_cholesterol_mg": total_cholesterol
//       };

//       ori_len--;
//     }

//     _ref
//         .child(_instance.currentUser!.uid)
//         .child("all_data")
//         .child(months[(DateTime.now().month) - 1])
//         .child((DateTime.now().day - 2).toString())
//         // .child("31")
//         .child("date")
//         .set(dateFormat_1.format(DateTime.now()))
//         .then((value) => print("date added"));
//     _ref
//         .child(_instance.currentUser!.uid)
//         .child("all_data")
//         .child(months[(DateTime.now().month) - 1])
//         .child((DateTime.now().day - 2).toString())
//         // .child("31")
//         .child("foodData")
//         // .child(dateFormat_2.format(DateTime.now()))
//         .set(foodNutrData)
//         .then((value) {
//       print(_avgData["avgFat"]);
//       print(foodNutrData["total_nutrients"]["total_fat_g"]);
//       double _avgFat = (_avgData["avgFat"] +
//               foodNutrData["total_nutrients"]["total_fat_g"]) /
//           2;
//       double _avgCalories = (_avgData["avgCalories"] +
//               foodNutrData["total_nutrients"]["total_cal_g"]) /
//           2;
//       double _avgProtein = (_avgData["avgProtein"] +
//               foodNutrData["total_nutrients"]["total_protein_g"]) /
//           2;
//       double _avgCarbs = (_avgData["avgCarbs"] +
//               foodNutrData["total_nutrients"]["total_carbs_g"]) /
//           2;
//       double _avgCholes = (_avgData["avgCholes"] +
//               foodNutrData["total_nutrients"]["total_cholesterol_mg"]) /
//           2;

//       _ref
//           .child(_instance.currentUser!.uid)
//           .child("all_data")
//           .child("avg")
//           .child(months[(DateTime.now().month) - 1])
//           .set({
//         "avgCarbs": _avgCarbs,
//         "avgGlucose": _avgData["avgGlucose"],
//         "avgFat": _avgFat,
//         "avgProtein": _avgProtein,
//         "avgCholes": _avgCholes,
//         "avgCalories": _avgCalories
//       }).then((value) {
//         print("success 1");
//       });
//     });
//     setState(() {
//       msg = "Stored Successfully";
//       final snackBar = SnackBar(
//           content: Text(
//         msg,
//         style: TextStyle(color: Colors.white),
//       ));

//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       state = true;

//       Navigator.pop(context);
//     });
//     print(foodNutrData);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey[200],
//         // appBar: AppBar(
//         //   title: Text('Dynamic TextFormFields'),
//         // ),
//         body: SafeArea(
//             child: Scaffold(
//           body: SingleChildScrollView(
//               child: Column(
//             children: [
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // SizedBox(
//                   //   width: 1,
//                   // ),
//                   Text(
//                     " Calorie Counter",
//                     // textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 40),
//                   ),
//                   IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: Icon(
//                         Icons.arrow_back_ios_new_outlined,
//                         size: 30,
//                         color: Colors.red,
//                       ))
//                 ],
//               ),
//               Form(
//                   key: _formKey,
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // name textfield
//                           // Padding(
//                           //   padding: const EdgeInsets.only(right: 32.0),
//                           //   child: TextFormField(
//                           //     controller: _nameController,
//                           //     decoration:
//                           //         InputDecoration(hintText: 'Enter your name'),
//                           //     validator: (v) {
//                           //       if (v!.trim().isEmpty)
//                           //         return 'Please enter something';
//                           //       return null;
//                           //     },
//                           //   ),
//                           // ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Text(
//                             'Add Foods',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w700, fontSize: 16),
//                           ),
//                           ..._getFoods(),
//                           SizedBox(
//                             height: 40,
//                           ),
//                           ElevatedButton(
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 _formKey.currentState!.save();
//                                 state = false;
//                                 print(foodsList);
//                                 getHealthDetails();
//                                 // if (state) {
//                                 final snackBar = SnackBar(
//                                     content: Text(
//                                   msg,
//                                   style: TextStyle(color: Colors.white),
//                                 ));

//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(snackBar);
//                                 // } else {
//                                 //   final snackBar = SnackBar(
//                                 //       content: Text(
//                                 //     "Processing",
//                                 //     style: TextStyle(color: Colors.white),
//                                 //   ));
//                                 //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                                 // }
//                                 // while (ori_len >= 0) {
//                                 //   // print(foodsList[ori_len]);
//                                 //   // ori_len--;
//                                 //   var value = getHealthDetails(foodsList[ori_len]);
//                                 //   print(value);
//                                 //   print("got it");
//                                 //   ori_len--;
//                                 // }
//                               }
//                             },
//                             child: Text('Submit'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ))
//             ],
//           )),
//         )));
//   }

//   /// get foods text-fields
//   List<Widget> _getFoods() {
//     List<Widget> foodsTextFields = [];
//     for (int i = 0; i < foodsList.length; i++) {
//       foodsTextFields.add(Padding(
//         padding: const EdgeInsets.symmetric(vertical: 16.0),
//         child: Row(
//           children: [
//             Expanded(child: FoodTextFields(i)),
//             SizedBox(
//               width: 16,
//             ),
//             // we need add button at last Foods row
//             _addRemoveButton(i == foodsList.length - 1, i),
//           ],
//         ),
//       ));
//     }
//     return foodsTextFields;
//   }

//   /// add / remove button
//   Widget _addRemoveButton(bool add, int index) {
//     return InkWell(
//       onTap: () {
//         if (add) {
//           // add new text-fields at the top of all Foods textfields
//           foodsList.insert(0, "");
//         } else
//           foodsList.removeAt(index);
//         setState(() {});
//       },
//       child: Container(
//         width: 30,
//         height: 30,
//         decoration: BoxDecoration(
//           color: (add) ? Colors.green : Colors.red,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Icon(
//           (add) ? Icons.add : Icons.remove,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

// class FoodTextFields extends StatefulWidget {
//   final int index;
//   FoodTextFields(this.index);
//   @override
//   _FoodTextFieldsState createState() => _FoodTextFieldsState();
// }

// class _FoodTextFieldsState extends State<FoodTextFields> {
//   late TextEditingController _nameController;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _nameController.text = AcademicDetailsScreenState.foodsList[widget.index];
//     });

//     return TextFormField(
//       controller: _nameController,
//       onChanged: (v) => AcademicDetailsScreenState.foodsList[widget.index] = v,
//       decoration: InputDecoration(hintText: 'Enter your Food name'),
//       validator: (v) {
//         if (v!.trim().isEmpty) return 'Please enter something';
//         return null;
//       },
//     );
//   }
// }
