import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreen createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage('https://salt.tikicdn.com/ts/upload/c2/bc/6d/ff18cc8968e2bbb43f7ac58efbfafdff.png'),
                  ),
                  SizedBox(height: 10),
                  Text("Phạm Đình Khôi", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("sdsdsd@gmail.com", style: TextStyle(color: Colors.grey))
                  ],
                ),
              ),
            ),

            SettingsSection([
              SettingsItem(Icons.person, "Personal info"),
            ]),
            SettingsSection([
              SettingsItem(Icons.lock, "Password and security",),
              SettingsItem(Icons.apps, "App and services"),
              SettingsItem(Icons.privacy_tip, "Privacy"),
              SettingsItem(Icons.devices, "Devices"),
            ]),
          ],
        ),
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final List<Widget> items;
  SettingsSection(this.items);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: Column(children: items),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  SettingsItem(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(title),
      onTap: () {},
    );
  }
}

