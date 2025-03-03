class SignupModel {
  final String userName;
  final String email;
  final String password;
  final DateTime dateOfBirth;
  final String fullName;
  final int gender;

  SignupModel({
    required this.userName,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.fullName,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {"userName": userName, "email": email, "password": password, "dateOfBirth": dateOfBirth.toIso8601String(), "fullName": fullName, "gender": gender};
  }
}
