import 'package:connectify/domain/controllers/register_controller.dart';
import 'package:connectify/presentation/widgets/dialog/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:connectify/presentation/widgets/custom_text_field.dart';
import 'package:connectify/presentation/widgets/primary_button.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final registerController = Provider.of<RegisterController>(context);

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
              errorText: registerController.nameError,
            ),
            CustomTextField(
              label: 'Email',
              icon: Icons.email,
              controller: _emailController,
              errorText: registerController.emailError,
            ),
            CustomTextField(
              label: 'Password',
              icon: Icons.lock,
              controller: _passwordController,
              errorText: registerController.passwordError,
              isPassword: true,
            ),
            CustomTextField(
              label: 'Confirm password',
              icon: Icons.person,
              controller: _confirmPasswordController,
              errorText: registerController.confirmPasswordError,
              isPassword: true,
            ),

            SizedBox(height: 10),
            registerController.isLoading
                ? Center(child: CircularProgressIndicator())
                : PrimaryButton(
              text: 'Sign up',
              onPressed: () async {
                final response = await registerController.register(
                  context: context,
                  name: _nameController.text,
                  email: _emailController.text,
                  password: _passwordController.text,
                  confirmPassword: _confirmPasswordController.text,
                );
              },
            ),
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
