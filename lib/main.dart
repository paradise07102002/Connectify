import 'package:connectify/core/utils/navigator_service.dart';
import 'package:connectify/data/providers/user_provider.dart';
import 'package:connectify/data/providers/check_field_provider.dart';
import 'package:connectify/domain/controllers/auth/login_controller.dart';
import 'package:connectify/domain/controllers/auth/signup_controller.dart';
import 'package:connectify/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoginController()),
      ChangeNotifierProvider(create: (context) => CheckFieldProvider()),
      ChangeNotifierProvider(create: (context) => SignupController()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
