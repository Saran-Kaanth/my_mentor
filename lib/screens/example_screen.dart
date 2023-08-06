// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';

// void main() {
//   runApp( MaterialApp(
//        home: Home()
//   ));
// }

// class Home extends  StatefulWidget {
//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   final ImagePicker imgpicker = ImagePicker();
//   String imagepath = "";
//   late File imagefile; 
  
//   Future<File?> _getImage(ImageSource source) async {
//     // final bool isGranted = await _requestPermission();
//     // if (!isGranted) {
//     //   return null;
//     // }
//     final ImagePicker _picker =   ImagePicker();
//     final XFile? image = await _picker.pickImage(source: source);
//     if (image != null) {
//       return File(image.path);
//     }
//     return null;
//   }

//   _cropImage() async {
//     File? croppedfile = (await ImageCropper.cropImage(
//       sourcePath: imagepath,
//       aspectRatioPresets: [
//         CropAspectRatioPreset.square,
//         CropAspectRatioPreset.ratio3x2,
//         CropAspectRatioPreset.original,
//         CropAspectRatioPreset.ratio4x3,
//         CropAspectRatioPreset.ratio16x9
//       ],
      
//     )) as File?;

//     if (croppedfile != null) {
//       imagefile = croppedfile;
//       setState(() { });
//     } else{
//       print("Image is not cropped.");
//     }
//   }

//   _saveImage() {
//     Uint8List bytes = await imagefile.readAsBytes();
//     var result = await ImageGallerySaver.saveImage(
//       bytes,
//       quality: 80,
//       name: "my_mage.jpg"
//     );
//     if(result["isSuccess"] == true){
//       print("Image saved successfully.");
//     } else{
//       print(result["errorMessage"]);
//     }
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: Text("Open Image, Crop and Save"),
//         backgroundColor: Colors.deepPurpleAccent,
//       ),
//       body: Container(
//         margin: EdgeInsets.only(top:30),
//         alignment: Alignment.center,
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             imagepath != "" ? Image.file(imagefile) :
//               Container( 
//                 child: Text("No Image selected."),
//               ),
            
//             Row( 
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 //open button ----------------
//                 ElevatedButton(
//                   onPressed: (){
//                       _getImage(ImageSource.gallery);
//                   }, 
//                   child: Text("Open Image")
//                 ),

//                 //crop button --------------------
//                 imagepath != "" ? ElevatedButton(
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
//                   onPressed: (){
//                       _cropImage();
//                   }, 
//                   child: Text("Crop Image")
//                 ): Container(),

//                 //save button -------------------
//                 imagepath != "" ? ElevatedButton(
//                 onPressed: () async {
//                   Uint8List bytes = await imagefile.readAsBytes();
//                   var result = await ImageGallerySaver.saveImage(
//                     bytes,
//                     quality: 60,
//                     name: "new_mage.jpg"
//                   );
//                   print(result);
//                   if(result["isSuccess"] == true){
//                     print("Image saved successfully.");
//                   }else{
//                     print(result["errorMessage"]);
//                   }
//                 }, 
//                 child: Text("Save Image")
//                 ): Container(),

//               ],

//             )
//           ],
//         ),
//       )
//     );
//   }
// }