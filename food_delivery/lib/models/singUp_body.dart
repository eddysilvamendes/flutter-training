class SignUpBody {
  String name;
  String phone;
  String email;
  String password;

  SignUpBody({
    required this.name,
    required this.password,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["f_name"] = name;
    data["password"] = password;
    data["phone"] = phone;
    data["email"] = email;
    return data;
  }
}
