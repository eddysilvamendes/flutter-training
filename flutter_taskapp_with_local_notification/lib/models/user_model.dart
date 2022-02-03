class User {
  int? id;
  String? username;
  String? email;
  String? about;

  User({
    this.id,
    this.username,
    this.about,
    this.email,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    username = json["username"];
    email = json["email"];
    about = json["about"];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> userdata = Map<String, dynamic>();
    userdata["id"] = id;
    userdata["username"] = username;
    userdata["email"] = email;
    userdata["about"] = about;

    return userdata;
  }
}
