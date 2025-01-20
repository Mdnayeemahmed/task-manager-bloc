import 'package:flutter/material.dart';
import 'package:task_manager_ostad/ui/widgets/screen_background.dart';
import 'package:task_manager_ostad/ui/widgets/tm_app_bar.dart';

class AddNewTaskListScreen extends StatefulWidget {
  const AddNewTaskListScreen({super.key});
  static const String name = '/add-new-task';
  @override
  State<AddNewTaskListScreen> createState() => _AddNewTaskListScreenState();
}

class _AddNewTaskListScreenState extends State<AddNewTaskListScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Add New Task',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: textTheme.titleSmall,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle: textTheme.titleSmall,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Icon(Icons.arrow_circle_right_outlined))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
