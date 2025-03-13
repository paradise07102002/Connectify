import 'package:connectify/domain/controllers/auth/signup_controller.dart';
import 'package:connectify/presentation/widgets/buttons/primary_button.dart';
import 'package:connectify/presentation/widgets/fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  final String fullName;
  final DateTime birthDay;
  final int gender;

  const AccountScreen({super.key, 
    required this.fullName,
    required this.birthDay,
    required this.gender,
  });

  @override
  _AccountScreen createState() => _AccountScreen();
}

class _AccountScreen extends State<AccountScreen> {

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get the screen size to make the UI responsive
    final size = MediaQuery.of(context).size;

    final signupController = Provider.of<SignupController>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Tạo tài khoản")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
        child: Column(
          children: [
            CustomTextField(label: "User name", icon: Icons.people, controller: _userNameController, errorText: signupController.nameError,),
            SizedBox(height: size.height * 0.01),
            CustomTextField(label: "Email", icon: Icons.people, controller: _emailController, errorText: signupController.emailError,),
            SizedBox(height: size.height * 0.01),
            CustomTextField(label: "Password", icon: Icons.people, controller: _passwordController, errorText: signupController.passwordError,),
            SizedBox(height: size.height * 0.01),
            CustomTextField(label: "Confirm Password", icon: Icons.people, controller: _confirmPasswordController, errorText: signupController.confirmPasswordError,),
            SizedBox(height: size.height * 0.01),
            signupController.isLoading
                ? Center(child: CircularProgressIndicator())
                : PrimaryButton(
              text: "Tạo tài khoản",
              color: Colors.blueAccent,
              onPressed: () async {
                await signupController.register(
                  context: context,
                  userName: _userNameController.text,
                  email: _emailController.text,
                  password: _passwordController.text,
                  confirmPassword: _confirmPasswordController.text,
                  fullName: widget.fullName,
                  dateOfBirth: widget.birthDay,
                  gender: widget.gender
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
