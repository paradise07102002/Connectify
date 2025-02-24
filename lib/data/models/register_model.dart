class RegisterModel {
  final String userName;
  final String email;
  final String password;

  RegisterModel({
    required this.userName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {"userName": userName, "email": email, "password": password};
  }
}
