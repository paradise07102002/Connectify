import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Image.asset(
        'assets/images/logo_connectify.png',
        width: size.width * 0.5,
      ),
    );
  }
}
