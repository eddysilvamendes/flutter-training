class UserModel {
  int id;
  String name;
  String email;
  String phone;
  int orderCount;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.orderCount,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["f_name"],
      email: json["email"],
      orderCount: json["order_count"],
      phone: json["phone"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['f_name'] = name;
    data['email'] = email;
    data['order_count'] = orderCount;
    data['phone'] = phone;

    return data;
  }
}
