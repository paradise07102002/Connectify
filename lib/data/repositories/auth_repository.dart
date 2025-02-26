import 'dart:convert';
import 'dart:ffi';
import 'package:connectify/data/models/login_model.dart';
import 'package:connectify/data/models/register_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String baseUrl = "http://10.0.2.2:5151/api/Users";
  SharedPreferences? _prefs;

  AuthRepository() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //Register
  Future<Map<String, dynamic>> register(RegisterModel register) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(register.toJson()),
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

        if (data.containsKey('token') && data['token'] is String) {
          final token = data['token'];

          try {
            await _prefs?.setString("jwt_token", token);
          } catch (e) {
            return {"error": "Lỗi khi lưu token: $e"};
          }

          return {"token": token};
        }
      } else {
        try {
          final Map<String, dynamic> errorData = jsonDecode(response.body);
          return {"error": errorData["message"] ?? "Đăng nhập thất bại"};
        } catch (_) {
          return {"error": "Đăng nhập thất bại: ${response.body}"};
        }
      }
    } catch (e) {
      return {"error": "Lỗi kết nối: $e"};
    }
    return {"error": "Đăng nhập thất bại"};
  }

  //Get token for login
  Future<String?> getToken() async {
    try {
      return _prefs?.getString("jwt_token");
    } catch (e) {
      return null;
    }
  }

  //Delete token for log out
  Future<void> logout() async {
    try {
      await _prefs?.remove("jwt_token");
    } catch (e) {
      print("Lỗi xóa token: $e");
    }
  }
}
