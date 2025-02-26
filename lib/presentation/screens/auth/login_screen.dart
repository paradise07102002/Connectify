import 'package:connectify/domain/controllers/auth/login_controller.dart';
import 'package:connectify/presentation/widgets/buttons/primary_button.dart';
import 'package:connectify/presentation/widgets/fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Login"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Center(
              child: Image.asset(
                'assets/images/logo_connectify.png',
                width: 300,
              ),
            ),
            SizedBox(height: 16),
            CustomTextField(
              label: "Email",
              icon: Icons.email,
              controller: _emailController,
              errorText: loginController.emailError,
            ),
            SizedBox(height: 16),
            CustomTextField(
              label: "Password",
              icon: Icons.lock,
              controller: _passwordController,
              errorText: loginController.passwordError,
              isPassword: true,
            ),
            SizedBox(height: 24),

            loginController.isLoading
                ? Center(child: CircularProgressIndicator())
                : PrimaryButton(
                  text: "Login",
                  onPressed: () async {
                    await loginController.login(
                      context: context,
                      email: _emailController.text.trim(),
                      password: _passwordController.text,
                    );
                  },
                ),

            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(onPressed: () {}, child: Text("Sign up")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
