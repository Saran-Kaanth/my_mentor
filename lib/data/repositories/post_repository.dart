import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_mentor/data/repositories/models/post.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostRepository {
  final currentUser = FirebaseAuth.instance.currentUser!;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref("postDetails");
  final Reference storageRef = FirebaseStorage.instance.ref();

  Future<dynamic> retrievePostDetail() async {
    try {
      await dbRef.child(currentUser.uid).get().then((value) {});
    } catch (e) {}
  }

  Future<dynamic> storePostImage(String filePath) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      Reference imageUploadRef = storageRef
          .child("images")
          .child(currentUser.uid.toString())
          .child("posts")
          .child(uniqueFileName);
      await imageUploadRef.putFile(File(filePath));
      return imageUploadRef.getDownloadURL();
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
