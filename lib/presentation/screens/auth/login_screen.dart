import 'package:connectify/domain/controllers/auth/login_controller.dart';
import 'package:connectify/presentation/widgets/buttons/primary_button.dart';
import 'package:connectify/presentation/widgets/fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    //
    final loginController = Provider.of<LoginController>(context);

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
              Center(
                child: Image.asset(
                  'assets/images/logo_connectify.png',
                  width: size.width * 0.5,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              CustomTextField(
                label: "Email",
                icon: Icons.email,
                controller: _emailController,
                errorText: loginController.emailError,
              ),
              SizedBox(height: size.height * 0.01),
              CustomTextField(
                label: "Password",
                icon: Icons.lock,
                isPassword: true,
                controller: _passwordController,
                errorText: loginController.passwordError,
              ),
              SizedBox(height: size.height * 0.01),

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
              SizedBox(height: size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ?"),
                  TextButton(onPressed: () {}, child: Text("Sign up")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
