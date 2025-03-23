import 'dart:convert';
import 'package:connectify/data/models/login_model.dart';
import 'package:connectify/data/models/signup_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  // final String baseUrl = "http://10.0.2.2:5151/api/Auth";
  final String baseUrl = "http://192.168.1.27:5151/api/Auth";
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  //Register
  Future<Map<String, dynamic>> register(SignupModel signup) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(signup.toJson()),
      );

      return _handleResponse(response, successStatus: 201);
    } catch (e) {
      return {"error": "Lỗi kết nối: $e"};
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

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await secureStorage.write(key: 'access_token', value: data['accessToken']);
        await secureStorage.write(key: 'refresh_token', value: data['refreshToken']);
        return {"accessToken": data['accessToken'], "refreshToken": data['refreshToken']};
      }

      return _handleError(response);
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
      final refreshToken = await secureStorage.read(key: 'refresh_token');
      if (refreshToken == null) return false;

      final response = await http.post(
        Uri.parse('$baseUrl/refresh-token'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"refreshToken": refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await secureStorage.write(key: 'access_token', value: data['accessToken']);
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  //Logout function (remove token)
  Future<bool> logout() async {
    final refreshToken = await secureStorage.read(key: 'refresh_token');
    if (refreshToken == null) return false;

    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    return response.statusCode == 200;
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

  Map<String, dynamic> _handleResponse(http.Response response, {required int successStatus}) {
    if (response.statusCode == successStatus) {
      return jsonDecode(response.body);
    }
    return _handleError(response);
  }
}
