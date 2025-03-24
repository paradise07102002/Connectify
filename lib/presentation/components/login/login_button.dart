import 'package:connectify/domain/controllers/auth/login_controller.dart';
import 'package:connectify/presentation/screens/main_screen.dart';
import 'package:connectify/presentation/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);
    return loginController.isLoading
        ? Center(child: CircularProgressIndicator())
        : PrimaryButton(
          text: 'Login',
          onPressed: () async {
            await loginController.login(
              context: context,
              email: emailController.text.trim(),
              password: passwordController.text,
              onError: (message) {
                Fluttertoast.showToast(
                  msg: message,
                  backgroundColor: Colors.red,
                );
              },
              onSuccess: () {
                Fluttertoast.showToast(
                  msg: "Login Success",
                  backgroundColor: Colors.green,
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  (route) => false,
                );
              },
            );
          },
        );
  }
}
