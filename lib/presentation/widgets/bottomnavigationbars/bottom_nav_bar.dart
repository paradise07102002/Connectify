import 'package:flutter/material.dart';
import 'nav_item.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: NavItem(icon: Icons.home, label: 'Home', index: 0, selectedIndex: selectedIndex, onTap: onItemTapped)),
          Expanded(child: NavItem(icon: Icons.search, label: 'Search', index: 1, selectedIndex: selectedIndex, onTap: onItemTapped)),
          SizedBox(width: 40),
          Expanded(child: NavItem(icon: Icons.group, label: 'Community', index: 3, selectedIndex: selectedIndex, onTap: onItemTapped)),
          Expanded(child: NavItem(icon: Icons.settings, label: 'Settings', index: 4, selectedIndex: selectedIndex, onTap: onItemTapped)),
        ],
      ),
    );
  }
}
