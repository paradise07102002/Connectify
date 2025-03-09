import 'package:flutter/material.dart';

class CheckFieldProvider with ChangeNotifier {
  bool isLoading = false;

  String? errorMessage;

  bool checkNull({
    required BuildContext context,
    required String input,
    required String lableError,
  }) {
    errorMessage = input.trim().isEmpty ? lableError : null;

    if (errorMessage != null) {
      notifyListeners();
      return true;
    }

    return false;
  }
}
