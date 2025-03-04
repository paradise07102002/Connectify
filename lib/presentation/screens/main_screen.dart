import 'package:connectify/presentation/screens/setting_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('', style: TextStyle(fontSize: 24))),
    Center(child: Text('Tìm kiếm', style: TextStyle(fontSize: 24))),
    Center(child: Text('Tài khoản', style: TextStyle(fontSize: 24))),
    SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(preferredSize: Size.fromHeight(2.0), child: Container(color: Colors.grey, height: 1.0,)),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        title: Text('Connectify', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: Icon(Icons.people))
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search_off), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.add_a_photo_outlined), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.group), label: 'Community'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'settings'),
        ],
      )
    );
  }
}