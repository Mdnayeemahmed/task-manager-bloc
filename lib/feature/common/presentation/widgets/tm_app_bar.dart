import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../app/styling/app_colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_ostad/feature/auth/data/models/user_model.dart';

import '../../../auth/presentation/ui/screens/sign_in_screen.dart';
import '../blocs/auth_cubit.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({Key? key, this.fromUpdateProfile = false}) : super(key: key);
  final bool fromUpdateProfile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: themeColor,
      title: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final UserModel? user = state.user;
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (!fromUpdateProfile) {
                    // Navigator.pushNamed(context, UpdateProfileScreen.name);
                  }
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: user?.photo != null && user!.photo!.isNotEmpty
                      ? MemoryImage(base64Decode(user.photo!))
                      : null,
                  child: user?.photo == null || user!.photo!.isEmpty
                      ? const Icon(Icons.person)
                      : null,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.fullName ?? '',
                      style: textTheme.titleMedium?.copyWith(color: Colors.white),
                    ),
                    Text(
                      user?.email ?? '',
                      style: textTheme.titleSmall?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  await context.read<AuthCubit>().logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, SignInScreen.name, (predicate) => false);
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
