import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  SettingsItem(this.icon, this.title);

  @override
  Widget build(BuildContext) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(title),
      onTap: () {},
    );
  }
}
