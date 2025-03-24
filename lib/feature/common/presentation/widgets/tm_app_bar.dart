import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:task_manager_ostad/app/app_router.dart';
import '../../../../app/service_locator.dart';
import '../../../../app/styling/app_colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_ostad/feature/auth/data/models/user_model.dart';

import '../../../auth/presentation/ui/screens/sign_in_screen.dart';
import '../../../profile/presentation/ui/update_profile_screen.dart';
import '../blocs/user_management_cubit.dart';

// class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const TMAppBar({Key? key, this.fromUpdateProfile = false}) : super(key: key);
//   final bool fromUpdateProfile;
//
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//
//     return AppBar(
//       backgroundColor: themeColor,
//       title: BlocProvider(
//         create: (_) => UserManagementCubit((sl()))..loadUser(),
//         child: BlocBuilder<UserManagementCubit, UserManagementState>(
//           builder: (context, state) {
//             final UserModel? user = state.user;
//             // log(state.user!.firstName.toString());
//             log("from App bar");
//             return Row(
//               children: [
//                 GestureDetector(
//                   onTap: () async {
//                     if (!fromUpdateProfile) {
//                       AppRouter.navigateTo(context, UpdateProfileScreen.name);
//
//                       // Navigator.pushNamed(context, UpdateProfileScreen.name);
//                     }
//                   },
//                   child: CircleAvatar(
//                     radius: 20,
//                     backgroundImage:
//                         user?.photo != null && user!.photo!.isNotEmpty
//                             ? MemoryImage(base64Decode(user.photo!))
//                             : null,
//                     child: user?.photo == null || user!.photo!.isEmpty
//                         ? const Icon(Icons.person)
//                         : null,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         user?.firstName ?? '',
//                         style: textTheme.titleMedium
//                             ?.copyWith(color: Colors.white),
//                       ),
//                       Text(
//                         user?.email ?? '',
//                         style:
//                             textTheme.titleSmall?.copyWith(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () async {
//                     await context.read<UserManagementCubit>().logout();
//                     AppRouter.go(context, SignInScreen.name);
//                   },
//                   icon: const Icon(
//                     Icons.logout,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_ostad/feature/auth/data/models/user_model.dart';

// class MyAppBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserManagementCubit, UserManagementState>(
//       builder: (context, state) {
//         // Check if user is logged in
//         final user = state.user;
//         return AppBar(
//           backgroundColor: themeColor,
//           title: Row(
//             children: [
//               GestureDetector(
//                 onTap: () async {
//                   if (!fromUpdateProfile) {
//                     AppRouter.navigateTo(context, UpdateProfileScreen.name);
//                   }
//                 },
//                 child: CircleAvatar(
//                   radius: 20,
//                   backgroundImage: user?.photo != null && user!.photo!.isNotEmpty
//                       ? MemoryImage(base64Decode(user.photo!))
//                       : null,
//                   child: user?.photo == null || user!.photo!.isEmpty
//                       ? const Icon(Icons.person)
//                       : null,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       user?.firstName ?? '',
//                       style: textTheme.titleMedium?.copyWith(color: Colors.white),
//                     ),
//                     Text(
//                       user?.email ?? '',
//                       style: textTheme.titleSmall?.copyWith(color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//               IconButton(
//                 onPressed: () async {
//                   await context.read<UserManagementCubit>().logout();
//                   AppRouter.go(context, SignInScreen.name);
//                 },
//                 icon: const Icon(
//                   Icons.logout,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           )
//         );
//       },
//     );
//   }
// }

// class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const TMAppBar({Key? key, this.fromUpdateProfile = false}) : super(key: key);
//   final bool fromUpdateProfile;
//
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//
//     return AppBar(
//       backgroundColor: themeColor,
//       title: BlocBuilder<UserManagementCubit, UserManagementState>(
//         builder: (context, state) {
//           final UserModel? user = state.user;
//
//           log("from App bar");
//
//           return Row(
//             children: [
//               GestureDetector(
//                 onTap: () async {
//                   if (!fromUpdateProfile) {
//                     AppRouter.navigateTo(context, UpdateProfileScreen.name);
//                   }
//                 },
//                 child: CircleAvatar(
//                   radius: 20,
//                   backgroundImage: user?.photo != null && user!.photo!.isNotEmpty
//                       ? MemoryImage(base64Decode(user.photo!))
//                       : null,
//                   child: user?.photo == null || user!.photo!.isEmpty
//                       ? const Icon(Icons.person)
//                       : null,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       user?.firstName ?? '',
//                       style: textTheme.titleMedium?.copyWith(color: Colors.white),
//                     ),
//                     Text(
//                       user?.email ?? '',
//                       style: textTheme.titleSmall?.copyWith(color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//               IconButton(
//                 onPressed: () async {
//                   await context.read<UserManagementCubit>().logout();
//                   AppRouter.go(context, SignInScreen.name);
//                 },
//                 icon: const Icon(
//                   Icons.logout,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({Key? key, this.fromUpdateProfile = false}) : super(key: key);
  final bool fromUpdateProfile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => UserManagementCubit(sl())..loadUserProfile(),
      child: BlocBuilder<UserManagementCubit, UserManagementState>(
        builder: (context, state) {
          if (state is userProfileLoaded) {
            final user = state.user;

            // Check if user is logged in
            return AppBar(
              backgroundColor: themeColor,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (!fromUpdateProfile) {
                        final result = await AppRouter.navigateTo(
                            context, UpdateProfileScreen.name);

                        if (result == true) {
                          context.read<UserManagementCubit>().loadUserProfile();
                          log("called result");
                        }
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
                          state.user?.firstName ?? '',
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
                      await context.read<UserManagementCubit>().logout();
                      AppRouter.go(context, SignInScreen.name);
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Fallback state
            return AppBar(
              backgroundColor: themeColor,
              title: Row(
                children: const [Text('Loading...', style: TextStyle(color: Colors.white))],
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
