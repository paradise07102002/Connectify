import 'dart:io';
import 'package:connectify/data/models/user_model.dart';
import 'package:connectify/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingController with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final String accessTokenKey = 'access_token';
  final String refreshTokenKey = 'refresh_token';

  UserModel? _userModel;
  bool _isLoading = true;

  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;

  Future<void> loadUserData() async {
    final String? accessToken = await _secureStorage.read(key: accessTokenKey);
    if (accessToken != null) {
      _userModel = await _userRepository.fetchUserInfo(accessToken);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> uploadAvatar(File imageFile) async {
    _isLoading = true;
    notifyListeners();

    String? newAvatarUrl = await _userRepository.uploadAvatar(imageFile);
    if (newAvatarUrl != null) {
      _userModel?.avatarUrl = newAvatarUrl;

      final String? accessToken = await _secureStorage.read(
        key: accessTokenKey,
      );

      if (accessToken != null) {
        _userModel = await _userRepository.fetchUserInfo(accessToken);
      }

      Fluttertoast.showToast(
        msg: "Cập nhật ảnh đại diện thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white
      );
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }
}
