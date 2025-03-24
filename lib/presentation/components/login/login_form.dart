import 'package:connectify/domain/controllers/auth/login_controller.dart';
import 'package:connectify/presentation/widgets/fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);
    return Column(
      children: [
        CustomTextField(
          label: 'Email',
          icon: Icons.email,
          controller: emailController,
          errorText: loginController.emailError,
        ),
        SizedBox(height: 10),
        CustomTextField(
          label: 'Password',
          icon: Icons.lock,
          isPassword: true,
          controller: passwordController,
          errorText: loginController.passwordError,
        ),
      ],
    );
  }
}
