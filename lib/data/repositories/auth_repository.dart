import 'dart:convert';
import 'package:connectify/data/models/login_model.dart';
import 'package:connectify/data/models/signup_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String baseUrl = "http://10.0.2.2:5151/api/Auth";

  //Register
  Future<Map<String, dynamic>> register(SignupModel signup) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(signup.toJson()),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        try {
          final Map<String, dynamic> errorData = jsonDecode(response.body);
          return {"error": errorData["message"] ?? "Đăng ký thất bại"};
        } catch (_) {
          return {"error": "Đăng ký thất bại: ${response.body}"};
        }
      }
    } catch (e) {
      return {"error": "Lỗi kết nối: $e"};
    }
  }

  //Helper function to handle errors from response
  Map<String, dynamic> _handleError(http.Response response) {
    try {
      final Map<String, dynamic> errorData = jsonDecode(response.body);
      return {"error": errorData["message"] ?? "Something went wrong"};
    } catch (_) {
      return {"error": "Unexpected error: ${response.body}"};
    }
  }

  //Login
  Future<Map<String, dynamic>> login(LoginModelRequest login) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(login.toJson()),
      );

      if (response.statusCode != 200) return _handleError(response);

      final data = jsonDecode(response.body);
      final token = data['token'];

      if (token is String) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("jwt_token", token);
        return {"token": token};
      }

      return {"error": "Invalid token received"};
    } catch (e) {
      return {"error": "Connection error: $e"};
    }
  }

  //Get AccessToken
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("accessToken");
  }

  //Get RefreshToken
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("refreshToken");
  }

  //Logout function (remove token)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("jwt_token");
  }
}
