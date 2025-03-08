import 'dart:convert';
import 'package:connectify/data/models/login_model.dart';
import 'package:connectify/data/models/signup_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
      final accessToken = data['accessToken'];
      final refreshToken = data['refreshToken'];

      if (accessToken is String && refreshToken is String) {
        final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
        await secureStorage.write(key: 'access_token', value: accessToken);
        await secureStorage.write(key: 'refresh_token', value: refreshToken);
        return {"accessToken": accessToken, "refreshToken": refreshToken};
      }

      return {"error": "Invalid"};
    } catch (e) {
      return {"error": "Connection error: $e"};
    }
  }

  //Get RefreshToken
  Future<String?> getRefreshToken() async {
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

    return secureStorage.read(key: 'refresh_token');
  }

  //Update Access Token with Refresh Token when expired
  Future<bool> refreshAccessToken() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null) return false;

      final response = await http.post(
        Uri.parse('$baseUrl/refresh'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"refresh": refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newAccessToken = data['accessToken'];

        if (newAccessToken is String) {
          final FlutterSecureStorage secureStorage =
              const FlutterSecureStorage();
          await secureStorage.write(key: 'access_token', value: newAccessToken);
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  //Logout function (remove token)
  Future<bool> logout(String refreshToken) async {
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
