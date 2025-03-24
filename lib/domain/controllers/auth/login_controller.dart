import 'package:connectify/data/models/login_model.dart';
import 'package:connectify/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;

  String? emailError, passwordError;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> login({
    required BuildContext context,
    required String email,
    required String password,
    required Function(String) onError,
    required Function() onSuccess,
  }) async {
    emailError = email.trim().isEmpty ? "Please enter Email" : null;
    passwordError = password.isEmpty ? "Please enter Password" : null;

    if (emailError != null || passwordError != null) {
      notifyListeners();
      return null;
    }

    _setLoading(true);

    try {
      final login = LoginModelRequest(email: email.trim(), password: password);

      final response = await _authRepository.login(login);

      if (response.containsKey("error")) {
        onError(response['error']);
      } else {
        onSuccess();
      }

      return response;
    } finally {
      _setLoading(false);
    }
  }
}
