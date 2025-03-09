import 'package:connectify/data/models/user_model.dart';
import 'package:connectify/data/repositories/user_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProvider with ChangeNotifier {
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
}
