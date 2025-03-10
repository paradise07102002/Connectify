class UserModel {
  final String id;
  final String username;
  final String email;
  final String? fullName;
  final String? bio;
  final String? avatarUrl;
  final String? coverUrl;
  final String? dateOfBirth;
  final int gender;
  final String createdAt;
  final bool isVerified;
  final bool isActive;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.fullName,
    this.bio,
    this.avatarUrl,
    this.coverUrl,
    this.dateOfBirth,
    required this.gender,
    required this.createdAt,
    required this.isVerified,
    required this.isActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      fullName: json["fullName"],
      bio: json["bio"],
      avatarUrl: json["avatarUrl"],
      coverUrl: json["coverUrl"],
      dateOfBirth: json["dateOfBirth"],
      gender: json["gender"],
      createdAt: json["createdAt"],
      isVerified: json["isVerified"],
      isActive: json["isActive"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "fullName": fullName,
      "bio": bio,
      "avatarUrl": avatarUrl,
      "coverUrl": coverUrl,
      "dateOfBirth": dateOfBirth,
      "gender": gender,
      "createdAt": createdAt,
      "isVerified": isVerified,
      "isActive": isActive,
    };
  }
}
