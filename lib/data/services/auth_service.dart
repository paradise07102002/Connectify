import 'package:connectify/core/utils/navigator_service.dart';
import 'package:connectify/data/repositories/auth_repository.dart';
import 'package:connectify/presentation/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const String accessTokenKey = "access_token";
  static const String refreshTokenKey = "refresh_token";

  final AuthRepository _authRepository = AuthRepository();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await secureStorage.read(key: accessTokenKey);
    return token != null && token.isNotEmpty;
  }

  /// Save accessToken and refreshToken to SharedPreferences
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await secureStorage.write(key: accessTokenKey, value: accessToken);
    await secureStorage.write(key: refreshTokenKey, value: refreshToken);
  }

  /// Refresh token when needed
  Future<bool> refreshTokenIfNeeded() async {
    final success = await _authRepository.refreshAccessToken();
    if (!success) {
      _forceLogout();
    }
    return success;
  }

  /// Clear token and redirect to login screen
  void _forceLogout() async {
    await secureStorage.delete(key: accessTokenKey);
    await secureStorage.delete(key: refreshTokenKey);

    // Điều hướng về màn hình Welcome
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
      (Route<dynamic> route) => false, 
    );
  }

  /// Get accessToken
  Future<String?> getAccessToken() async {
    return secureStorage.read(key: accessTokenKey);
  }

  /// Get refreshToken
  Future<String?> getRefreshToken() async {
    return secureStorage.read(key: refreshTokenKey);
  }

  /// Delete token on logout
  Future<bool> logout() async {
    bool success = await _authRepository.logout();
    if (success) {
      await secureStorage.delete(key: accessTokenKey);
      await secureStorage.delete(key: refreshTokenKey);
    }
    return success;
  }
}
