import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_ostad/feature/profile/presentation/blocs/image_picker_state.dart';


import '../../../../app/app_router.dart';
import '../../../../app/service_locator.dart';
import '../../../common/presentation/widgets/center_circular_progress_indicator.dart';
import '../../../common/presentation/widgets/snack_bar_message.dart';
import '../../../common/presentation/widgets/tm_app_bar.dart';
import '../blocs/image_picker_cubit.dart';
import '../blocs/update_profile_cubit.dart';
import 'dart:typed_data';  // Add this import for Uint8List




class UpdateProfileScreen extends StatefulWidget {
  static const String name = '/update-profile';

  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late ProfileCubit _profileTaskBloc;

  @override
  void initState() {
    super.initState();
    _profileTaskBloc = ProfileCubit(sl(), sl());
    _profileTaskBloc.loadUserProfile();
  }

  Widget _buildTextField(TextEditingController controller, String hintText, bool isRequired,
      {bool isNumber = false, bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: isRequired
          ? (value) {
        if (value?.trim().isEmpty ?? true) {
          return 'Please enter your $hintText';
        }
        return null;
      }
          : null,
    );
  }

  // Modified _buildPhotoPicker to accept a BuildContext parameter.
  Widget _buildPhotoPicker(BuildContext context) {
    // Retrieve the current profile state to access user data.
    final profileState = context.watch<ProfileCubit>().state;
    final user = profileState is ProfileLoaded ? profileState.user : null;

    return BlocBuilder<ImagePickerCubit, ImagePickerState>(
      builder: (context, imagePickerState) {
        if (imagePickerState is ImagePickerLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (imagePickerState is ImagePickerPicked) {
          return GestureDetector(
            onTap: () => context.read<ImagePickerCubit>().pickImage(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: FileImage(File(imagePickerState.image.path)),
                fit: BoxFit.cover,
              ),
            ),
          );
        }
        if (user?.photo != null && user!.photo!.isNotEmpty) {
          return GestureDetector(
            onTap: () => context.read<ImagePickerCubit>().pickImage(),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: MemoryImage(base64Decode(user.photo!)),
            ),
          );
        }
        return _buildDefaultAvatar(context);
      },
    );
  }

  Widget _buildDefaultAvatar(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<ImagePickerCubit>().pickImage(),
      child: const CircleAvatar(
        radius: 50,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future<void> _onTapUpdateProfile(
      BuildContext context,
      String email,
      String firstName,
      String lastName,
      String mobile,
      ) async {
    if (_formKey.currentState!.validate()) {
      String? photo;
      final state = context.read<ImagePickerCubit>().state;
      if (state is ImagePickerPicked) {
        // Convert the image to base64
        Uint8List imageBytes = await state.image.readAsBytes();
        photo = base64Encode(imageBytes);
      }
      context.read<ProfileCubit>().updateProfile(
        email: email,
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
        photo: photo,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const TMAppBar(fromUpdateProfile: true),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => _profileTaskBloc,
          ),
          BlocProvider(
            create: (context) => ImagePickerCubit(),
          ),
        ],
        child: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            debugPrint('Current state: $state');

            if (state is ProfileUpdateFailure) {
              showSnackBarMessage(context, state.failure.message);
            }
            if (state is ProfileUpdateSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  AppRouter.pop(context, result: true);
                }
              });
              showSnackBarMessage(context, 'Profile updated successfully!');
            }
          },
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadInProgress || state is ProfileUpdateInProgress) {
                return const CenterCircularProgressIndicator();
              }
              if (state is ProfileLoadFailure) {
                return Center(child: Text('Failed to load profile: ${state.failure.message}'));
              }

              if (state is ProfileLoaded) {
                final user = state.user;
                log(state.user.toString());
                final _emailTEController = TextEditingController(text: user.email);
                final _firstNameTEController = TextEditingController(text: user.firstName);
                final _lastNameTEController = TextEditingController(text: user.lastName);
                final _mobileTEController = TextEditingController(text: user.mobile);

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 25),
                          Text('Update Profile', style: textTheme.titleLarge),
                          const SizedBox(height: 24),
                          // Pass the inner context to _buildPhotoPicker
                          _buildPhotoPicker(context),
                          const SizedBox(height: 8),
                          _buildTextField(_emailTEController, 'Email', false),
                          const SizedBox(height: 8),
                          _buildTextField(_firstNameTEController, 'First Name', true),
                          const SizedBox(height: 8),
                          _buildTextField(_lastNameTEController, 'Last Name', true),
                          const SizedBox(height: 8),
                          _buildTextField(_mobileTEController, 'Mobile', true, isNumber: true),
                          const SizedBox(height: 8),
                          _buildTextField(TextEditingController(), 'Password', true, obscureText: true),
                          const SizedBox(height: 16),
                          state is ProfileUpdateInProgress
                              ? const CenterCircularProgressIndicator()
                              : ElevatedButton(
                            onPressed: () {
                              _onTapUpdateProfile(
                                context,
                                _emailTEController.text,
                                _firstNameTEController.text,
                                _lastNameTEController.text,
                                _mobileTEController.text,
                              );
                            },
                            child: const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}

