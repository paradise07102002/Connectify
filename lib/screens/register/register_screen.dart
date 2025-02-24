import 'package:connectify/models/register_model/user_register.dart';
import 'package:flutter/material.dart';
import 'package:connectify/widgets/custom_text_field.dart';
import 'package:connectify/widgets/primary_button.dart';
import 'package:connectify/services/auth_service.dart';
import 'package:connectify/widgets/custom_dialog.dart';
import 'package:connectify/screens/login/login_screen.dart';

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

  final AuthService _authService = AuthService();
  bool _isLoading = false;

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

    //Check Password and ConfirmPassword
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Passwords do not match")));
      return;
    }

    setState(() => _isLoading = true);

    final user = UserRegisterRequest(
      userName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    final response = await _authService.register(user);

    setState(() => _isLoading = false);

    if (response.containsKey("error")) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response["error"])));
    } else {
      _showVerificationDialog();
    }
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
              label: 'Password',
              icon: Icons.lock,
              controller: _passwordController,
              errorText: _passwordError,
              isPassword: true,
            ),
            CustomTextField(
              label: 'Confirm password',
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

  //Hàm thông báo xác thực email
  void _showVerificationDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false, // Không cho đóng khi chạm bên ngoài
      barrierLabel: "Xác thực email",
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return CustomDialog(
          title: "Xác thực email",
          content: "Vui lòng kiểm tra email để xác thực",
          onClose: () {
            Navigator.pop(context); // Đóng hộp thoại
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
          scale: anim1.value,
          child: Opacity(opacity: anim1.value, child: child),
        );
      },
    );
  }

  //Hàm cập nhật lại để hiển thị lỗi
  void _showFieldErrors() {
    setState(() {}); // Cập nhật lại UI để hiển thị lỗi
  }
}
