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
    
    // Get the screen size to make the UI responsive
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true
        ),
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
                  width: size.width * 0.5
                ),
              ),
              SizedBox(height: size.height * 0.01),
              CustomTextField(label: "Email", icon: Icons.email),
              SizedBox(height: size.height * 0.01),
              CustomTextField(label: "Password", icon: Icons.lock, isPassword: true),
              SizedBox(height: size.height * 0.01),
              PrimaryButton(text: "Login", onPressed: () {}),
              SizedBox(height: size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ?"),
                  TextButton(onPressed: () {}, child: Text("Sign up"))
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
