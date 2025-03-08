import 'package:connectify/core/utils/auth_service.dart';
import 'package:connectify/domain/controllers/logout_controller.dart';
import 'package:connectify/presentation/screens/welcome/welcome_screen.dart';
import 'package:connectify/presentation/widgets/settings/settings_item.dart';
import 'package:connectify/presentation/widgets/settings/settings_section.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreen createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // Get the screen size to make the UI responsive
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: size.width * 0.15,
                      backgroundImage: NetworkImage(
                        'https://static.wikia.nocookie.net/lookism/images/b/bb/525_Young_Shingen.png/revision/latest?cb=20241024142804',
                      ),
                    ),
                    Text(
                      'Phạm Đình Khôi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('pdk@gmail.com', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),

            SizedBox(height: size.height * 0.02),

            SettingsSection([SettingsItem(Icons.person, 'Account & Profile')]),
            SettingsSection([
              SettingsItem(
                Icons.logout,
                'Logout',
                onTap: () async {
                  bool success = await _authService.logout();
                  if (success) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (route) => false
                    );
                  }
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
