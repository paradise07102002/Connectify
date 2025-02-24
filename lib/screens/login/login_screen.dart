import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  __LoginScreenState createState() => __LoginScreenState();
}

class __LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Center(
              child: Image.asset(
                'assets/images/logo_connectify.png',
                width: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
