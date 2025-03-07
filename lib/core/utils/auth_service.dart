import 'package:connectify/core/utils/navigator_service.dart';
import 'package:connectify/presentation/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String baseUrl = "http://10.0.2.2:5151/api/Auth";

  static const String accessTokenKey = "access_token";
  static const String refreshTokenKey = "refresh_token";

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(accessTokenKey);
    return token != null && token.isNotEmpty;
  }

  /// Save accessToken and refreshToken to SharedPreferences
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, accessToken);
    await prefs.setString(refreshTokenKey, refreshToken);
  }

  Future<bool> refreshTokenIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString("refresh_token");

    if (refreshToken == null || refreshToken.isEmpty) {
      return false; // Không có refresh token để làm mới
    }

    final response = await http.post(
      Uri.parse("$baseUrl/refresh-token"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refreshToken": refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await prefs.setString("access_token", data["accessToken"]);
      await prefs.setString("refresh_token", data["refreshToken"]);
      return true; // Refresh thành công
    }

    return false; // Refresh thất bại
  }

  /// Clear token and redirect to login screen
  void _forceLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(accessTokenKey);
    await prefs.remove(refreshTokenKey);

    // Go back to Welcome screen
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
      (Route<dynamic> route) => false, //Clear all stack navigation
    );
  }

  /// Get accessToken
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey);
  }

  /// Get refreshToken
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(refreshTokenKey);
  }

  /// Delete token on logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(accessTokenKey);
    await prefs.remove(refreshTokenKey);
  }
}
