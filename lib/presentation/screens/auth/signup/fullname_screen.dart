import 'package:connectify/domain/controllers/auth/signup_controller.dart';
import 'package:connectify/presentation/screens/auth/signup/birthday_screen.dart';
import 'package:connectify/presentation/widgets/buttons/primary_button.dart';
import 'package:connectify/presentation/widgets/fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullnameScreen extends StatefulWidget {
  const FullnameScreen({super.key});

  @override
  State<FullnameScreen> createState() => _FullnameScreen();
}

class _FullnameScreen extends State<FullnameScreen> {
  @override
  Widget build(BuildContext context) {
    // Get the screen size to make the UI responsive
    final size = MediaQuery.of(context).size;

    final checkFieldNull = Provider.of<SignupController>(context);

    final TextEditingController fullNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Bạn tên là gì?")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: 'Họ và tên',
              icon: Icons.people,
              controller: fullNameController,
              errorText: checkFieldNull.errorMessage,
            ),
            SizedBox(height: size.height * 0.01),
            PrimaryButton(
              text: "Tiếp",
              color: Colors.blueAccent,
              onPressed: () {
                bool check = checkFieldNull.checkNull(
                  context: context,
                  input: fullNameController.text.trim(),
                  lableError: "Vui lòng nhập tên của bạn",
                );
                
                if (check == true) {
                  return;
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BirthdayScreen(fullName: fullNameController.text.trim())),
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
