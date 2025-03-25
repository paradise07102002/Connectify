import 'package:connectify/data/services/auth_service.dart';
import 'package:connectify/domain/controllers/setting/setting_controller.dart';
import 'package:connectify/presentation/components/settings/settings_list.dart';
import 'package:connectify/presentation/components/settings/settings_profile_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    Provider.of<SettingController>(context, listen: false).loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true),
      body: Consumer<SettingController>(
        builder: (context, userProvider, child) {
          return userProvider.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  children: [
                    SettingsProfileHeader(),
                    SizedBox(height: 20),
                    SettingsList(authService: _authService),
                  ],
                ),
              );
        },
      ),
    );
  }
}
