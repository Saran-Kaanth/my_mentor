import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_mentor/data/models/post.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostRepository {
  final currentUser = FirebaseAuth.instance.currentUser!;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref("postDetails");
  final Reference storageRef = FirebaseStorage.instance.ref();

  Future<List<Post>> retrieveMyPostDetail({String? userId}) async {
    List<Post> myPostsList = [];
    try {
      // print(userId.toString() + " in function");
      print(userId);
      userId = userId == "" ? currentUser.uid : userId;
      await dbRef.orderByChild("authorId").equalTo(userId).once().then((value) {
        if (value.snapshot.value == null) {
          return myPostsList;
        } else {
          Map myPosts = value.snapshot.value as Map;
          myPosts.values.forEach((element) {
            myPostsList.add(Post.fromMap(element));
            // print(myPostsList);
          });
          // print("data is there" + myPostsList[0].authorId.toString());
          return myPostsList;
        }
      });
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    return myPostsList;
    // return [];
  }

  Future<String> storePostImage(String? filePath) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    // print("function added");
    try {
      Reference imageUploadRef = storageRef
          .child("images")
          .child(currentUser.uid.toString())
          .child("posts")
          .child(uniqueFileName);
      await imageUploadRef.putFile(File(filePath!));
      // print(imageUploadRef.getDownloadURL());
      return await imageUploadRef.getDownloadURL();
    } catch (e) {
      // print("error");
      // print(e.toString());
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

  Future<List<Post>> retrieveAllPosts() async {
    List<Post> allPostsList = [];
    try {
      print("Repo started");
      await dbRef.once().then((value) {
        if (value.snapshot.value == null) {
          return allPostsList;
        } else {
          Map allPosts = value.snapshot.value as Map;
          allPosts.values.forEach((element) {
            allPostsList.add(Post.fromMap(element));
          });
          allPostsList.shuffle();
          return allPostsList;
        }
      });
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
    return allPostsList;
  }

  Future<String> getAuthorImg(String authorId) async {
    String authorImg =
        "https://www.google.com/imgres?imgurl=https%3A%2F%2Fmedia.istockphoto.com%2Fid%2F1393750072%2Fvector%2Fflat-white-icon-man-for-web-design-silhouette-flat-illustration-vector-illustration-stock.jpg%3Fs%3D612x612%26w%3D0%26k%3D20%26c%3Ds9hO4SpyvrDIfELozPpiB_WtzQV9KhoMUP9R9gVohoU%3D&tbnid=Eck3-Z1-_NVGmM&vet=10CDsQMyiCAWoXChMI2PPIxvfOgAMVAAAAAB0AAAAAEAM..i&imgrefurl=https%3A%2F%2Fwww.istockphoto.com%2Fphotos%2Fblank-profile-picture&docid=rRWD3SDgbLRjnM&w=612&h=612&q=link%20for%20empty%20user%20profile%20image&safe=active&ved=0CDsQMyiCAWoXChMI2PPIxvfOgAMVAAAAAB0AAAAAEAM";
    return authorImg;
  }
}
