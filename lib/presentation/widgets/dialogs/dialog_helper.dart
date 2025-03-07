import 'package:connectify/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  // Hiển thị Dialog thông báo lỗi
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text("Error", style: TextStyle(color: Colors.red)),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

  // Hiển thị Dialog thông báo thành công
  static void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text("Success", style: TextStyle(color: Colors.green)),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
                child: Text("OK"),
              ),
            ],
          ),
    );
  }
}
