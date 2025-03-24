import 'package:connectify/core/utils/avatar_utils.dart';
import 'package:connectify/data/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsProfileHeader extends StatelessWidget {
  const SettingsProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            AvatarUtils.showAvatarOptions(
              context,
              userProvider.userModel?.avatarUrl ?? '',
            );
          },
          child: CircleAvatar(
            radius: size.width * 0.15,
            backgroundImage: NetworkImage(
              userProvider.userModel?.avatarUrl ?? ''
            ),
          ),
        ),
        Text(userProvider.userModel?.fullName ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(userProvider.userModel?.email ?? '', style: TextStyle(color: Colors.grey))
      ],
    );
  }
}
