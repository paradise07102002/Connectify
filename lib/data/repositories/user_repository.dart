import 'dart:convert';
import 'package:connectify/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  String baseUrl = "http://10.0.2.2:5151/api/User";
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<UserModel?> fetchUserInfo(String accessToken) async {
    final response = await http.get(
      Uri.parse("$baseUrl/me"),
      headers: {
        "Authorization": "Bearer $accessToken",
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return UserModel.fromJson(jsonData);
    } else {
      print("error: ${response.statusCode}");
      return null;
    }
  }
}
