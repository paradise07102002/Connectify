import 'dart:io';
import 'package:connectify/data/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AvatarUtils {
  static final ImagePicker _picker = ImagePicker();

  static Future<void> pickAndUploadImage(BuildContext context) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) return;

    File imageFile = File(pickedFile.path);
    bool? isConfirm = await changeAvatar(context, imageFile);

    if (isConfirm == true && context.mounted) {
      await Provider.of<UserProvider>(
        context,
        listen: false,
      ).uploadAvatar(imageFile);
    }
  }

  //Show Options to choose to view or replace photos
  static Future<void> showAvatarOptions(
    BuildContext context,
    String imageUrl,
  ) async {
    if (!context.mounted) return;

    await showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.image),
              title: Text("Xem ảnh đại diện"),
              onTap: () {
                Navigator.pop(bottomSheetContext);
                showFullAvatar(context, imageUrl);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Thay ảnh đại diện"),
              onTap: () async {
                Navigator.pop(bottomSheetContext);
                if (context.mounted) {
                  await pickAndUploadImage(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  //Show full screen image
  static void showFullAvatar(BuildContext context, String imageUrl) async {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: true,
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  Center(child: Image.network(imageUrl, fit: BoxFit.contain)),
                  Positioned(
                    top: 40,
                    right: 20,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //change avatar
  static Future<bool?> changeAvatar(
    BuildContext context,
    File imageFile,
  ) async {
    return await Navigator.of(context).push<bool>(
      PageRouteBuilder(
        opaque: true,
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  Center(child: Image.file(imageFile, fit: BoxFit.contain)),
                  Positioned(
                    top: 40,
                    right: 20,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.white, size: 30),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 50,
                    right: 50,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Đặt ảnh đại diện",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
