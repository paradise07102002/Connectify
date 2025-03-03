import 'package:connectify/domain/controllers/check_field_controller.dart';
import 'package:connectify/presentation/screens/auth/signup/gender_screen.dart';
import 'package:connectify/presentation/widgets/buttons/primary_button.dart';
import 'package:connectify/presentation/widgets/fields/date_picker_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BirthdayScreen extends StatefulWidget {
  final String fullName;

  BirthdayScreen({required this.fullName});

  @override
  _BirthdayScreen createState() => _BirthdayScreen();
}

class _BirthdayScreen extends State<BirthdayScreen> {
  @override
  Widget build(BuildContext context) {
    // Get the screen size to make the UI responsive
    final size = MediaQuery.of(context).size;

    final checkFieldNull = Provider.of<CheckFieldController>(context);

    final TextEditingController _birthDayController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Sinh nhật của bạn")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.01),
            DatePickerTextField(
              controller: _birthDayController,
              labelText: "Sinh nhật",
              errorMessage: checkFieldNull.errorMessage,
            ),
            SizedBox(height: size.height * 0.01),
            PrimaryButton(
              text: "Tiếp",
              color: Colors.blueAccent,
              onPressed: () {
                bool check = checkFieldNull.checkNull(
                  context: context,
                  input: _birthDayController.text.trim(),
                  lableError: "Vui lòng chọn ngày sinh của bạn",
                );

                if (check == true) {
                  return;
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenderScreen(fullName: widget.fullName, birthDay: DateTime.parse(_birthDayController.text.trim())),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
