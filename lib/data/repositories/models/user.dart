class UserProfileDetailsModel {
  final String? userId;
  final String? email;
  String? displayName;
  String? fullName;
  String? dob;
  String? photoUrl;
  String? occupation;
  String? headline;
  String? city;
  String? state;
  String? country;
  String? phone;
  List? connectionList;
  int? connections;
  List? skills;
  bool? isMentor;
  final bool? emailVerified;

  UserProfileDetailsModel(
      this.userId,
      this.displayName,
      this.fullName,
      this.dob,
      this.photoUrl,
      this.occupation,
      this.headline,
      this.email,
      this.city,
      this.state,
      this.country,
      this.phone,
      this.connectionList,
      this.connections,
      this.skills,
      this.isMentor,
      this.emailVerified);

  UserProfileDetailsModel.fromMap(Map<dynamic, dynamic> userProfileData)
      : userId = userProfileData["userId"],
        email = userProfileData["email"],
        displayName = userProfileData["displayName"],
        fullName = userProfileData["fullName"],
        dob = userProfileData["dob"],
        photoUrl = userProfileData["photoUrl"],
        occupation = userProfileData["occupation"],
        headline = userProfileData["headline"],
        city = userProfileData["city"],
        state = userProfileData["state"],
        country = userProfileData["country"],
        phone = userProfileData["phone"],
        connectionList = userProfileData["connectionList"],
        connections = userProfileData["connections"],
        skills = userProfileData["skills"],
        isMentor = userProfileData["isMentor"],
        emailVerified = userProfileData["emailVerified"];

  Map<String, dynamic> toMap() {
    return {
      "userid": userId,
      "email": email,
      "displayName": displayName,
      "fullName": fullName,
      "dob": dob,
      "photoUrl": photoUrl,
      "occupation": occupation,
      "headline": headline,
      "city": city,
      "state": state,
      "country": country,
      "phone": phone,
      "connectionList": connectionList,
      "connections": connections,
      "skills": skills,
      "isMentor": isMentor,
      "emailVerified": emailVerified
    };
  }
  // UserPersonalDetailsModel.fromMap(Map<String,dynamic> userProfileData):
  // id=userProfileData["userId"],
}

// class Book {
//   final int? id;
//   final String? title;
//   int? year;
//   List? sampleList = [];

//   Book({this.id, this.title, this.year, this.sampleList});

//   Book.fromMap(Map<String, dynamic> data)
//       : id = data['id'],
//         title = data['title'],
//         year = data['year'],
//         sampleList = data["sampleList"];

//   Map<String, dynamic> toMap() {
//     return {'id': id, 'title': title, 'year': year, 'list': sampleList};
//   }
// }
