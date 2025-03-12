import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager_ostad/ui/screens/sign_in_screen.dart';
import 'package:task_manager_ostad/ui/screens/update_profile_screen.dart';
import '../../feature/auth/data/repositories/auth_local_data_source.dart';
import '../controllers/auth_controller.dart';
import '../utills/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    this.fromUpdateProfile = false,
  });
  final bool fromUpdateProfile;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: AppColor.themeColor,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (!fromUpdateProfile) {
                Navigator.pushNamed(context, UpdateProfileScreen.name);
              }
            },
            child: CircleAvatar(
              radius: 20,
              backgroundImage: MemoryImage(
                  base64Decode(AuthLocalDataSource.userModel?.photo ?? '')),
              onBackgroundImageError: (_, __) => const Icon(Icons.person),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AuthLocalDataSource.userModel?.fullName ?? '',
                    style:
                        textTheme.titleMedium?.copyWith(color: Colors.white)),
                Text(
                  AuthLocalDataSource.userModel?.email ?? '',
                  style: textTheme.titleSmall?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              await AuthLocalDataSource.clearUserData();
              Navigator.pushNamedAndRemoveUntil(
                  context, SignInScreen.name, (predicate) => false);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
