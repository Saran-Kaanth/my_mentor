import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_mentor/blocs/postBloc/post_bloc.dart';
import 'package:my_mentor/screens/my_profile_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_mentor/widgets.dart';

class PostAddScreen extends StatefulWidget {
  const PostAddScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => PostAddScreenState();
}

class PostAddScreenState extends State<PostAddScreen> {
  String postDescription = "";
  File? imageFile;
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
    // setState(() {
    //   imageFile = File(pickedFile!.path);
    // });
    print("cropped");
  }

  void cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (croppedImage != null) {
      setState(() {
        print("hello image");
        print(croppedImage);
        print(croppedImage.path);
        print(imageFile);
        imageFile = File(croppedImage.path);
      });
    } else {
      print("not cropped");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final postBloc = BlocProvider.of<PostBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a Post"),
        titleSpacing: 25,
        automaticallyImplyLeading: false,
        leading: IconButton(
            splashColor: Colors.white,
            splashRadius: 20,
            alignment: Alignment.centerLeft,
            onPressed: () {
              print("back");
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_sharp,
              size: 28,
            )),
        leadingWidth: 20,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.width / 13, horizontal: size.width / 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   height: size.height,
                //   width: size.width,
                //   color: Colors.blue,
                // )
                Stack(
                  alignment: Alignment(1.3, 1.3),
                  children: [
                    imageFile != null
                        ? Container(
                            child: Image.file(
                              imageFile!,
                              width: 200,
                              height: 150,
                              // fit: BoxFit.fill,
                            ),
                          )
                        : imageContainer(Icon(
                            Icons.image,
                            size: 60,
                          )),
                    FloatingActionButton(
                      onPressed: () async {
                        chooseImage(ImageSource.gallery);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        // color: Colors.blue,
                        // decoration: BoxDecoration(
                        //     // border: Border.all(color: Colors.deepOrangeAccent),
                        //     borderRadius: BorderRadius.circular(150)),
                        child: Icon(
                          Icons.edit,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                spaceBox(30),
                TextFormField(
                  // style: UIStuff.formInputStyle,
                  // controller: _noteController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: "Description",
                  ),
                  onChanged: (value) => postDescription = value.toString(),
                ),
                spaceBox(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocConsumer<PostBloc, PostState>(
                      listener: (context, state) {
                        if (state is PostUploadedState) {
                          Navigator.pop(context);
                          postBloc.add(PostLoadingEvent());
                        }
                      },
                      builder: (context, state) {
                        if (state is PostImageUploadingState) {
                          return CircularProgressIndicator();
                        }
                        return InkWell(
                          onTap: () async {
                            print("clicked");
                            print(imageFile!.path);
                            print(postDescription);
                            if (imageFile != "") {
                              postBloc.add(PostSubmittingEvent(
                                  imageFile!.path, postDescription));
                            }
                          },
                          splashColor: Colors.deepOrangeAccent,
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 2),
                              child: Text(
                                "Post It",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            width: 120,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border:
                                    Border.all(color: Colors.deepOrangeAccent)),
                          ),
                        );
                      },
                    )
                  ],
                ),
                BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    if (state is PostUploadingState) {
                      return Center(
                        child: Text(
                          "Post Uploading...",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      );
                    } else if (state is PostImageUploadingState) {
                      return Center(
                        child: Text(
                          "Image Uploading...",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      );
                    } else if (state is PostErrorState) {
                      return Center(
                        child: Text(
                          state.errorMessage,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      );
                    }
                    return Container();
                  },
                )
              ],
            )),
      ),
    );
  }

  Widget imageContainer(Widget widget) {
    return Container(
      height: 150,
      width: 200,
      // color: Colors.amber,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade700),
          borderRadius: BorderRadius.circular(10)),
      child: widget,
    );
  }
}
