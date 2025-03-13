import 'package:connectify/presentation/screens/auth/signup/account_screen.dart';
import 'package:flutter/material.dart';

class GenderScreen extends StatefulWidget {
  final String fullName;
  final DateTime birthDay;

  const GenderScreen({super.key, required this.fullName, required this.birthDay});

  @override
  _GenderScreen createState() => _GenderScreen();
}

class _GenderScreen extends State<GenderScreen> {
  // String? _selectedGender;

  int? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chọn Giới Tính")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioListTile<int>(
              title: Text("Nam"),
              value: 1,
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            RadioListTile<int>(
              title: Text("Nữ"),
              value: 2,
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            RadioListTile<int>(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Lựa chọn khác"),
                  Text(
                    "Chọn Tùy chọn khác nếu bạn thuộc giới tính khác hoặc không muốn tiết lộ.",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              value: 3,
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  _selectedGender == null
                      ? null
                      : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => AccountScreen(
                                  fullName: widget.fullName,
                                  birthDay: widget.birthDay,
                                  gender: _selectedGender ?? 3,
                                ),
                          ),
                        );
                      },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue,
                disabledBackgroundColor: Colors.blue.withOpacity(0.5),
              ),
              child: Text("Tiếp"),
            ),
          ],
        ),
      ),
    );
  }
}
