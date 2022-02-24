class User {
  int? id;
  String? username;
  String? email;
  String? about;
  String? imgPath;

  User({
    this.id,
    this.username,
    this.about,
    this.email,
    this.imgPath,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    username = json["username"];
    email = json["email"];
    about = json["about"];
    imgPath = json["imgPath"];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> userdata = Map<String, dynamic>();
    userdata["id"] = id;
    userdata["username"] = username;
    userdata["email"] = email;
    userdata["about"] = about;
    userdata["imgPath"] = imgPath;

    return userdata;
  }
}
