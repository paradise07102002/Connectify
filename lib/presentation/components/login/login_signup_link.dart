import 'package:flutter/material.dart';

class LoginSignupLink extends StatelessWidget {
  const LoginSignupLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account?"),
        TextButton(onPressed: () {}, child: Text("Sign up")),
      ],
    );
  }
}
