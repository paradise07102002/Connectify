import 'package:connectify/presentation/widgets/buttons/primary_button.dart';
import 'package:connectify/presentation/widgets/fields/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Center(child: Image.asset('assets/images/logo_connectify.png', width: 300)),
            SizedBox(height: 16),
            CustomTextField(label: "Email", icon: Icons.email),
            SizedBox(height: 16),
            CustomTextField(label: "Password", icon: Icons.lock, isPassword: true),
            SizedBox(height: 24),
            PrimaryButton(text: "Login", onPressed: () {}),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(onPressed: () {}, child: Text("Sign up"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
