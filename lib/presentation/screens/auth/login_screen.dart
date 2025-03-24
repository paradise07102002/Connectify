import 'package:connectify/presentation/components/login/login_button.dart';
import 'package:connectify/presentation/components/login/login_form.dart';
import 'package:connectify/presentation/components/login/login_logo.dart';
import 'package:connectify/presentation/components/login/login_signup_link.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // Get the screen size to make the UI responsive
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text("Login"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.045),

              LoginLogo(),
              SizedBox(height: size.height * 0.01),

              LoginForm(emailController: _emailController, passwordController: _passwordController),
              SizedBox(height: size.height * 0.01),

              LoginButton(emailController: _emailController, passwordController: _passwordController),
              SizedBox(height: size.height * 0.01),

              LoginSignupLink()
            ],
          ),
        ),
      ),
    );
  }
}
