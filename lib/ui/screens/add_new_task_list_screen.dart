import 'package:flutter/material.dart';
import 'package:task_manager_ostad/data/service/network_caller.dart';
import 'package:task_manager_ostad/data/utills/urls.dart';
import 'package:task_manager_ostad/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager_ostad/ui/widgets/screen_background.dart';
import 'package:task_manager_ostad/ui/widgets/snack_bar_message.dart';
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
  bool _createNewTaskInProgress = false;
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
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your title here';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle: textTheme.titleSmall,
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your description here';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Visibility(
                    visible: _createNewTaskInProgress==false,
                    replacement: const CenterCircularProgressIndicator(),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _createNewTask();
                          }
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createNewTask() async {
    _createNewTaskInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New",
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTaskUrl, body: requestBody);
    _createNewTaskInProgress=false;
    setState(() {});
    if(response.isSuccess){
      _clearTextField();
      showSnackBarMessage(context, 'New task added!');
    }else{
      showSnackBarMessage(context, response.errorMessage);
    }
  }

  void _clearTextField(){
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
