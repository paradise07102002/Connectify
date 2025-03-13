import 'package:connectify/core/utils/avatar_utils.dart';
import 'package:connectify/data/providers/user_provider.dart';
import 'package:connectify/data/services/auth_service.dart';
import 'package:connectify/presentation/screens/welcome/welcome_screen.dart';
import 'package:connectify/presentation/widgets/settings/settings_item.dart';
import 'package:connectify/presentation/widgets/settings/settings_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreen createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  final AuthService _authService = AuthService();

  String avatarError =
      "https://storage.googleapis.com/connectify-social-bucket/avatar/3b9ce54a-0e2a-456d-92c9-18eb86041078_f5e7ae7d-f344-4515-b2ce-2927808d1068_cancel-297373_1280.png";

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size to make the UI responsive
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true),
      body:
          userProvider.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Center(
                        child: Column(
                          children: [
                            Consumer<UserProvider>(
                              builder: (context, userProvider, child) {
                                return GestureDetector(
                                  onTap: () {
                                    AvatarUtils.showAvatarOptions(
                                      context,
                                      userProvider.userModel?.avatarUrl ?? avatarError,
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: size.width * 0.15,
                                    backgroundImage: NetworkImage(
                                      userProvider.userModel?.avatarUrl ?? avatarError,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Text(
                              userProvider.userModel?.fullName ?? "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              userProvider.userModel?.email ?? "",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.02),

                    SettingsSection([
                      SettingsItem(Icons.person, 'Account & Profile'),
                    ]),
                    SettingsSection([
                      SettingsItem(Icons.lock, 'Change password'),
                      SettingsItem(Icons.lock_clock, 'Privacy settings'),
                      SettingsItem(Icons.notifications, 'Notification'),
                      SettingsItem(Icons.language, 'Language'),
                    ]),
                    SettingsSection([
                      SettingsItem(
                        Icons.logout,
                        'Logout',
                        onTap: () async {
                          bool success = await _authService.logout();
                          if (success) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WelcomeScreen(),
                              ),
                              (route) => false,
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
