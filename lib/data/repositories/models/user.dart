class UserPersonalDetailsModel {
  final String? userId;
  final String? email;
  final String? displayName;
  final String? fullName;
  final String? dob;
  final String? occupation;
  final String? headline;
  final String? city;
  final String? state;
  final String? country;
  final String? phone;
  final List? connectionList;
  final int? connections;
  final bool? isMentor;

  UserPersonalDetailsModel(
      this.userId,
      this.email,
      this.displayName,
      this.fullName,
      this.dob,
      this.occupation,
      this.headline,
      this.city,
      this.state,
      this.country,
      this.phone,
      this.connectionList,
      this.connections,
      this.isMentor);

  UserPersonalDetailsModel.fromMap(Map<String, dynamic> userPersonalData)
      : userId = userPersonalData["userId"],
        email = userPersonalData["email"],
        displayName = userPersonalData["displayName"],
        fullName = userPersonalData["fullName"],
        dob = userPersonalData["dob"],
        occupation = userPersonalData["occupation"],
        headline = userPersonalData["headline"],
        city = userPersonalData["city"],
        state = userPersonalData["state"],
        country = userPersonalData["country"],
        phone = userPersonalData["phone"],
        connectionList = userPersonalData["connectionList"],
        connections = userPersonalData["connections"],
        isMentor = userPersonalData["isMentor"];

  // UserPersonalDetailsModel.fromMap(Map<String,dynamic> userPersonalData):
  // id=userPersonalData["userId"],
}



class Book {
  final int id;
  final String title;
  final int year;

  Book(this.id, this.title, this.year);

  Book.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        year = data['year'];

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'year': year};
  }
}
