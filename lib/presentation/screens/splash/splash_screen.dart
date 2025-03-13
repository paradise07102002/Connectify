import 'package:connectify/data/services/auth_service.dart';
import 'package:connectify/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:connectify/presentation/screens/welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();

  double _opacity = 0.0;
  double _scale = 0.8;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
  bool isLoggedIn = await _authService.isLoggedIn();
  bool refreshed = await _authService.refreshTokenIfNeeded();

  bool shouldGoToMainScreen = isLoggedIn || refreshed;

  Future.delayed(Duration(seconds: 2), () {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            shouldGoToMainScreen ? MainScreen() : WelcomeScreen(),
      ),
    );
  });
}


  void _startAnimation() {
  Future.delayed(Duration(milliseconds: 500), () {
    if (!mounted) return;
    setState(() {
      _opacity = 1.0;
      _scale = 1.2;
    });
  });

  Future.delayed(Duration(seconds: 3), () {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          duration: Duration(seconds: 1),
          opacity: _opacity,
          child: AnimatedScale(
            scale: _scale,
            duration: Duration(seconds: 1),
            curve: Curves.easeOut,
            child: Image.asset('assets/images/logo_connectify.png', width: 350),
          ),
        ),
      ),
    );
  }
}
