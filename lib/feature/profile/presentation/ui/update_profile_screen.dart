// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:task_manager_ostad/data/service/network_caller.dart';
// import 'package:task_manager_ostad/data/utills/urls.dart';
//
// import '../../../common/presentation/widgets/center_circular_progress_indicator.dart';
// import '../../../common/presentation/widgets/screen_background.dart';
// import '../../../common/presentation/widgets/tm_app_bar.dart';
//
// class UpdateProfileScreen extends StatefulWidget {
//   const UpdateProfileScreen({super.key});
//   static const String name = '/update-profile';
//
//   @override
//   State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
// }
//
// class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
//   final TextEditingController _emailTEController = TextEditingController();
//   final TextEditingController _firstNameTEController = TextEditingController();
//   final TextEditingController _lastNameTEController = TextEditingController();
//   final TextEditingController _mobileTEController = TextEditingController();
//   final TextEditingController _passwordTEController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   XFile? _pickedImage;
//   bool _updateProfileInProgress = false;
//   static const String updateProfileUrl = 'profileUpdate';
//   @override
//   void initState() {
//     super.initState();
//     _emailTEController.text = AuthController.userModel?.email ?? '';
//     _firstNameTEController.text = AuthController.userModel?.firstName ?? '';
//     _lastNameTEController.text = AuthController.userModel?.lastName ?? '';
//     _mobileTEController.text = AuthController.userModel?.mobile ?? '';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     return Scaffold(
//       appBar: const TMAppBar(
//         fromUpdateProfile: true,
//       ),
//       body: ScreenBackground(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(32),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     height: 25,
//                   ),
//                   Text(
//                     'Update Profile',
//                     style: textTheme.titleLarge,
//                   ),
//                   const SizedBox(
//                     height: 24,
//                   ),
//                   _buildPhotoPicker(),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   TextFormField(
//                     enabled: false,
//                     controller: _emailTEController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: const InputDecoration(
//                       hintText: 'Email',
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   TextFormField(
//                     controller: _firstNameTEController,
//                     decoration: const InputDecoration(
//                       hintText: 'First Name',
//                     ),
//                     validator: (String? value) {
//                       if (value?.trim().isEmpty ?? true) {
//                         return 'Enter your first name';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   TextFormField(
//                     controller: _lastNameTEController,
//                     decoration: const InputDecoration(
//                       hintText: 'Last Name',
//                     ),
//                     validator: (String? value) {
//                       if (value?.trim().isEmpty ?? true) {
//                         return 'Enter your last name';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   TextFormField(
//                     controller: _mobileTEController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                       hintText: 'Mobile',
//                     ),
//                     validator: (String? value) {
//                       if (value?.trim().isEmpty ?? true) {
//                         return 'Enter your mobile number';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   TextFormField(
//                     controller: _passwordTEController,
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       hintText: 'Password',
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   Visibility(
//                     visible: _updateProfileInProgress==false,
//                     replacement: const CenterCircularProgressIndicator(),
//                     child: ElevatedButton(
//                       onPressed: _onTapUpdateProfile,
//                       child: const Icon(Icons.arrow_circle_right_outlined),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPhotoPicker() {
//     final textTheme = Theme.of(context).textTheme;
//     return GestureDetector(
//       onTap: _pickImage,
//       child: Container(
//         height: 50,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Row(
//           children: [
//             Container(
//               height: 75,
//               width: 75,
//               decoration: const BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(8),
//                       bottomLeft: Radius.circular(8))),
//               child: const Center(
//                   child: Text(
//                 'Photos',
//                 style: TextStyle(color: Colors.white),
//               )),
//             ),
//             const SizedBox(
//               width: 48,
//             ),
//             Text(
//               _pickedImage == null ? 'no selected item' : _pickedImage!.name,
//               style: textTheme.titleSmall,
//               maxLines: 1,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _pickImage() async {
//     ImagePicker picker = ImagePicker();
//     XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       _pickedImage = image;
//       setState(() {});
//     }
//   }
//
//   void _onTapUpdateProfile() {
//     if (_formKey.currentState!.validate()) {
//       _updateProfile();
//     }
//   }
//
//   Future<void> _updateProfile() async {
//     _updateProfileInProgress = true;
//     setState(() {});
//
//     Map<String, dynamic> requestBody = {
//       "email": _emailTEController.text.trim(),
//       "firstName": _firstNameTEController.text.trim(),
//       "lastName": _lastNameTEController.text.trim(),
//       "mobile": _mobileTEController.text.trim(),
//     };
//     if(_pickedImage != null){
//       List<int> imageBytes =await _pickedImage!.readAsBytes();
//       requestBody['photo'] =base64Encode(imageBytes);
//     }
//     if(_passwordTEController.text.isNotEmpty){
//       requestBody['password'] = _passwordTEController.text;
//     }
//
//     final NetworkResponse response = await NetworkCaller.postRequest(
//         url: Urls.updateProfileUrl, body: requestBody);
//     _updateProfileInProgress=false;
//     setState(() {});
//     if(response.isSuccess){
//       _passwordTEController.clear();
//     } else{
//       showSnackBarMessage(context, response.errorMessage);
//     }
//   }
//
//
//   Future<void> _getProfileDetails() async {
//     _updateProfileInProgress = true;
//     setState(() {});
//
//
//     final NetworkResponse response = await NetworkCaller.getRequest(
//         url: "{{BaseUrl}}/ProfileDetails", );
//     _updateProfileInProgress=false;
//     setState(() {});
//     if(response.isSuccess){
//       _passwordTEController.clear();
//     } else{
//       showSnackBarMessage(context, response.errorMessage);
//     }
//   }
//
//
//   @override
//   void dispose() {
//     _emailTEController.dispose();
//     _firstNameTEController.dispose();
//     _lastNameTEController.dispose();
//     _mobileTEController.dispose();
//     _passwordTEController.dispose();
//     super.dispose();
//   }
// }
