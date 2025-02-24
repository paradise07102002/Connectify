import 'dart:convert';

import 'package:connectify/models/register_model/user_register.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://10.0.2.2:5151/api/Users";

  //Register
  Future<Map<String, dynamic>> register(UserRegisterRequest user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return {"error": "Register failed: ${response.body}"};
      }
    } catch (e) {
      return {"error": "Lỗi kết nối: $e"};
    }
  }
}
