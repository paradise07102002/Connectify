import 'package:connectify/core/utils/navigator_service.dart';
import 'package:connectify/domain/controllers/auth/login_controller.dart';
import 'package:connectify/domain/controllers/auth/signup_controller.dart';
import 'package:connectify/domain/controllers/home/comment_controller.dart';
import 'package:connectify/domain/controllers/home/home_controller.dart';
import 'package:connectify/domain/controllers/home/media_controller.dart';
import 'package:connectify/domain/controllers/setting/setting_controller.dart';
import 'package:connectify/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'core/utils/short_vi_messages.dart';

void main() {
  timeago.setLocaleMessages('vi_short', ShortViMessages());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => SignupController()),
        ChangeNotifierProvider(create: (context) => SettingController()),
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => CommentController()),
        ChangeNotifierProvider(create: (context) => MediaController()),
      ],
      child: MyApp(),
    ),
  );
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
