import 'package:connectify/data/models/register_model.dart';
import 'package:connectify/data/repositories/auth_repository.dart';
import 'package:connectify/presentation/widgets/dialogs/dialog_helper.dart';
import 'package:flutter/material.dart';

class RegisterController with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool isLoading = false;

  String? nameError, emailError, passwordError, confirmPasswordError;

  Future<Map<String, dynamic>?> register({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    nameError = name.trim().isEmpty ? "Please enter name" : null;
    emailError = email.trim().isEmpty ? "Please enter email" : null;
    passwordError = password.trim().isEmpty ? "Please enter password" : null;
    confirmPasswordError =
        confirmPassword.trim().isEmpty ? "Please confirm password" : null;

    if (nameError != null ||
        emailError != null ||
        passwordError != null ||
        confirmPasswordError != null) {
      notifyListeners();
      return null;
    }

    if (password != confirmPassword) {
      notifyListeners();
      DialogHelper.showErrorDialog(context, "Password do not match");
      return null;
    }

    isLoading = true;
    notifyListeners();

    final user = RegisterModel(
      userName: name.trim(),
      email: email.trim(),
      password: password,
    );

    final response = await _authRepository.register(user);

    isLoading = false;
    notifyListeners();

    if (response.containsKey("error")) {
      DialogHelper.showErrorDialog(context, response["error"]);
      return response;
    } else {
      DialogHelper.showSuccessDialog(context, "Register Successful!");
      return response;
    }
  }
}
