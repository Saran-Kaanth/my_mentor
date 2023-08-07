import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_mentor/data/repositories/models/post.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostRepository {
  final currentUser = FirebaseAuth.instance.currentUser!;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref("postDetails");
  final Reference storageRef = FirebaseStorage.instance.ref();

  Future retrieveMyPostDetail() async {
    List<Post> myPostsList = [];
    try {
      await dbRef
          .orderByChild("authorId")
          .equalTo(currentUser.uid)
          .once()
          .then((value) {
        if (value.snapshot.value == null) {
          print(myPostsList);
          print(myPostsList.runtimeType);
          return myPostsList;
        }
        Map myPosts = value.snapshot.value as Map;

        myPosts.forEach((key, value) {
          myPostsList.add(Post.fromMap(myPosts));
        });
        print(myPostsList);
        return myPostsList;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> storePostImage(String? filePath) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    print("function added");
    try {
      Reference imageUploadRef = storageRef
          .child("images")
          .child(currentUser.uid.toString())
          .child("posts")
          .child(uniqueFileName);
      await imageUploadRef.putFile(File(filePath!));
      print(imageUploadRef.getDownloadURL());
      return await imageUploadRef.getDownloadURL();
    } catch (e) {
      print("error");
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> uploadPost(Post post) async {
    print("post added");
    try {
      dbRef.push().set(post.toMap()).then((value) {
        print("Posted Successfully");
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
