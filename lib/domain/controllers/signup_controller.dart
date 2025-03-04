import 'package:connectify/data/models/signup_model.dart';
import 'package:connectify/data/repositories/auth_repository.dart';
import 'package:connectify/presentation/widgets/dialogs/dialog_helper.dart';
import 'package:connectify/core/utils/validators.dart';
import 'package:flutter/material.dart';

class SignupController with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool isLoading = false;

  String? nameError, emailError, passwordError, confirmPasswordError;

  Future<Map<String, dynamic>?> register({
    required BuildContext context,
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required DateTime dateOfBirth,
    required String fullName,
    required int gender, 
  }) async {
    nameError = userName.trim().isEmpty ? "Please enter user name" : null;
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

    if (!Validators.isValidEmail(email.trim())) {
      emailError = "Email không đúng định dạng";
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

    final user = SignupModel(
      userName: userName.trim(),
      email: email.trim(),
      password: password,
      fullName: fullName.trim(),
      dateOfBirth: dateOfBirth,
      gender: gender,
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
