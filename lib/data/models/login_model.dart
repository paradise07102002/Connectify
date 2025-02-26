class LoginModelRequest {
  final String email;
  final String password;

  LoginModelRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

class LoginModelResponse {
  final String token;

  LoginModelResponse({required this.token});

  factory LoginModelResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('token') && json['token'] is String) {
      return LoginModelResponse(token: json['token']);
    }
    throw Exception("Invalid response format: Missting 'token'");
  }

  Map<String, dynamic> toJson() {
    return {'token': token};
  }
}
