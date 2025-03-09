import 'package:connectify/core/utils/navigator_service.dart';
import 'package:connectify/data/repositories/auth_repository.dart';
import 'package:connectify/presentation/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String baseUrl = "http://10.0.2.2:5151/api/Auth";

  static const String accessTokenKey = "access_token";
  static const String refreshTokenKey = "refresh_token";

  final AuthRepository _authRepository = AuthRepository();

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    final token = await secureStorage.read(key: accessTokenKey);
    return token != null && token.isNotEmpty;
  }

  /// Save accessToken and refreshToken to SharedPreferences
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    await secureStorage.write(key: accessTokenKey, value: accessToken);
    await secureStorage.write(key: refreshTokenKey, value: refreshToken);
  }

  Future<bool> refreshTokenIfNeeded() async {
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    String? refreshToken = await secureStorage.read(key: refreshTokenKey);

    if (refreshToken == null || refreshToken.isEmpty) {
      _forceLogout(); // Refresh token does not exist => Log out
      return false;
    }

    final response = await http.post(
      Uri.parse("$baseUrl/refresh-token"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refreshToken": refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await saveTokens(data["accessToken"], data["refreshToken"]);
      return true; // Refresh thành công
    }

    _forceLogout();
    return false; // Refresh thất bại
  }

  /// Clear token and redirect to login screen
  void _forceLogout() async {
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    await secureStorage.delete(key: accessTokenKey);
    await secureStorage.delete(key: refreshTokenKey);

    // Go back to Welcome screen
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
      (Route<dynamic> route) => false, //Clear all stack navigation
    );
  }

  /// Get accessToken
  Future<String?> getAccessToken() async {
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    return secureStorage.read(key: accessTokenKey);
  }

  /// Get refreshToken
  Future<String?> getRefreshToken() async {
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    return secureStorage.read(key: refreshTokenKey);
  }

  /// Delete token on logout
  Future<bool> logout() async {
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    String? refreshToken = await secureStorage.read(key: refreshTokenKey);

    if (refreshToken == null || refreshToken.isEmpty) return false;
    bool success = await _authRepository.logout(refreshToken);
    if (success) {
      await secureStorage.delete(key: accessTokenKey);
      await secureStorage.delete(key: refreshTokenKey);
    }
    return success;
  }
}
