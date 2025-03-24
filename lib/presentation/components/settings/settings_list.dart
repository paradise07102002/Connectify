import 'package:connectify/data/services/auth_service.dart';
import 'package:connectify/presentation/screens/welcome/welcome_screen.dart';
import 'package:connectify/presentation/components/settings/settings_item.dart';
import 'package:connectify/presentation/components/settings/settings_section.dart';
import 'package:flutter/material.dart';

class SettingsList extends StatelessWidget {
  final AuthService authService;
  const SettingsList({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsSection([SettingsItem(Icons.person, 'Account & Profile')]),
        SettingsSection([
          SettingsItem(Icons.lock, 'Change Password'),
          SettingsItem(Icons.lock_clock, 'Privacy settings'),
          SettingsItem(Icons.notifications, 'Notification'),
          SettingsItem(Icons.language, 'Language'),
        ]),
        SettingsSection([
          SettingsItem(
            Icons.logout,
            'logout',
            onTap: () async {
              bool success = await authService.logout();
              if (success && context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  (route) => false,
                );
              }
            },
          ),
        ]),
      ],
    );
  }
}
