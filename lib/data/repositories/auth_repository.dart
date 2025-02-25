import 'dart:convert';
import 'package:connectify/data/models/register_model.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl = "http://10.0.2.2:5151/api/Users";

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
}
