import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  
  final List<Widget> items;
  SettingsSection(this.items);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 5, offset: Offset(0, 3))
        ],
      ),
      child: Column(
        children: items,
      ),
    );
  }
}
