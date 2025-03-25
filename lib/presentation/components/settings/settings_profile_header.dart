import 'package:connectify/core/utils/avatar_utils.dart';
import 'package:connectify/domain/controllers/setting/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsProfileHeader extends StatelessWidget {
  const SettingsProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<SettingController>(context);

    String avatarError =
      "https://storage.googleapis.com/connectify-social-bucket/avatar/3b9ce54a-0e2a-456d-92c9-18eb86041078_f5e7ae7d-f344-4515-b2ce-2927808d1068_cancel-297373_1280.png";

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            AvatarUtils.showAvatarOptions(
              context,
              userProvider.userModel?.avatarUrl ?? avatarError,
            );
          },
          child: CircleAvatar(
            radius: size.width * 0.15,
            backgroundImage: NetworkImage(
              userProvider.userModel?.avatarUrl ?? avatarError,
            ),
          ),
        ),
        Text(userProvider.userModel?.fullName ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(userProvider.userModel?.email ?? '', style: TextStyle(color: Colors.grey))
      ],
    );
  }
}
