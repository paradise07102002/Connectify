import 'package:connectify/data/models/login_model.dart';
import 'package:connectify/data/repositories/auth_repository.dart';
import 'package:connectify/presentation/widgets/dialogs/dialog_helper.dart';
import 'package:flutter/widgets.dart';

class LoginController with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool isLoading = false;

  String? emailError, passwordError;

  Future<Map<String, dynamic>?> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    emailError = email.trim().isEmpty ? "Please enter Email" : null;
    passwordError = password.isEmpty ? "Please enter password" : null;

    if (emailError != null || passwordError != null) {
      notifyListeners();
      return null;
    }

    isLoading = true;
    notifyListeners();

    final login = LoginModelRequest(email: email.trim(), password: password);

    final response = await _authRepository.login(login);

    isLoading = false;
    notifyListeners();

    if (response.containsKey("error")) {
      DialogHelper.showErrorDialog(context, response["error"]);
      return response;
    } else {
      DialogHelper.showSuccessDialog(context, "Đăng nhập thành công");
    }
  }
}
