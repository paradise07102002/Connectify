import 'package:flutter/material.dart';
import 'package:connectify/presentation/widgets/custom_text_field.dart';
import 'package:connectify/presentation/widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _nameError, _emailError, _passwordError, _confirmPasswordError;

  void _register() async {
    setState(() {
      _nameError =
          _nameController.text.trim().isEmpty ? "Please enter name" : null;
      _emailError =
          _emailController.text.trim().isEmpty ? "Please enter email" : null;
      _passwordError =
          _passwordController.text.trim().isEmpty
              ? "Please enter password"
              : null;
      _confirmPasswordError =
          _confirmPasswordController.text.trim().isEmpty
              ? "Please confirm your password"
              : null;
    });

    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _confirmPasswordController.text.trim().isEmpty) {
      _showFieldErrors();
      return;
    }
  }

  //The function updates again to display the error
  void _showFieldErrors() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign up'), centerTitle: true, elevation: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo_connectify.png',
                width: 300,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Create an Account',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            CustomTextField(
              label: 'Your Name',
              icon: Icons.person,
              controller: _nameController,
              errorText: _nameError,
            ),
            CustomTextField(
              label: 'Email',
              icon: Icons.email,
              controller: _emailController,
              errorText: _emailError,
            ),
            CustomTextField(
              label: 'Your Name',
              icon: Icons.lock,
              controller: _passwordController,
              errorText: _passwordError,
              isPassword: true,
            ),
            CustomTextField(
              label: 'Your Name',
              icon: Icons.person,
              controller: _confirmPasswordController,
              errorText: _confirmPasswordError,
              isPassword: true,
            ),

            SizedBox(height: 10),

            PrimaryButton(text: 'Sign up', onPressed: _register),
            SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text("Already have an account? Sign in"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
