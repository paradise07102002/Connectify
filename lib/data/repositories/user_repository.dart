import 'dart:convert';
import 'dart:io';
import 'package:connectify/data/models/user_model.dart';
import 'package:connectify/data/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as path;

class UserRepository {
  // String baseUrl = "http://10.0.2.2:5151/api/User";
  String baseUrl = "http://192.168.1.27:5151/api/User";
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

  Future<String?> uploadAvatar(File imageFile) async {
    final AuthService _authService = AuthService();

    try {
      String? accessToken = await _authService.getAccessToken();

      var request = http.MultipartRequest(
        "POST",
        Uri.parse("$baseUrl/upload-avatar"),
      );
      request.headers["Authorization"] = "Bearer $accessToken";

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
          filename: path.basename(imageFile.path),
        ),
      );

      var response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        return responseBody;
      }
    } catch (e) {
      print("Image loading error: $e");
    }
    return null;
  }
}
