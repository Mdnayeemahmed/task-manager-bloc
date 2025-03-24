import 'package:flutter/material.dart';
import 'package:task_manager_ostad/app/app_router.dart';
import 'package:task_manager_ostad/data/service/network_caller.dart';
import 'package:task_manager_ostad/data/utills/urls.dart';
import '../../../../../../app/service_locator.dart';
import '../../../../../common/presentation/widgets/center_circular_progress_indicator.dart';
import '../../../../../common/presentation/widgets/screen_background.dart';
import '../../../../../common/presentation/widgets/tm_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/add_new_task_cubit.dart';


class AddNewTaskListScreen extends StatefulWidget {
  const AddNewTaskListScreen({super.key});
  static const String name = '/add-new-task';

  @override
  State<AddNewTaskListScreen> createState() => _AddNewTaskListScreenState();
}

class _AddNewTaskListScreenState extends State<AddNewTaskListScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }

  void _clearTextField(){
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  void _showSnackBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    // Here we assume that TaskRepository is available. You can pass it from a higher level or create it here.
    return BlocProvider<AddNewTaskCubit>(
      create: (context) => AddNewTaskCubit(
        sl(), // Or pass your repository instance directly.
      ),
      child: BlocListener<AddNewTaskCubit, AddNewTaskState>(
        listener: (context, state) {
          if (state is AddNewTaskSuccessState) {
            _clearTextField();
            _showSnackBarMessage(context, 'New task added!');
          } else if (state is AddNewTaskFailureState) {
            _showSnackBarMessage(context, state.error);
          }
        },
        child: Scaffold(
          appBar: const TMAppBar(),
          body: ScreenBackground(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: _titleTEController,
                        decoration: InputDecoration(
                          hintText: 'Title',
                          hintStyle:
                          Theme.of(context).textTheme.titleSmall,
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
                          hintStyle:
                          Theme.of(context).textTheme.titleSmall,
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
                      BlocConsumer<AddNewTaskCubit, AddNewTaskState>(
                        listener: (context, state) {
                          if (state is AddNewTaskSuccessState) {
                            // Pop the screen when the task is successfully added
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (mounted) {  // Always check if the widget is still mounted before calling Navigator.pop
                                // Navigator.pop(context);
                                AppRouter.pop(context,result: true);
                              }
                            });
                          } else if (state is AddNewTaskFailureState) {
                            // Handle failure state and show an error message
                            _showSnackBarMessage(context, state.error);
                          }
                        },
                        builder: (context, state) {
                          bool isLoading = state is AddNewTaskLoadingState;

                          return Visibility(
                            visible: !isLoading,
                            replacement: const CenterCircularProgressIndicator(),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AddNewTaskCubit>().addNewTask(
                                    _titleTEController.text.trim(),
                                    _descriptionTEController.text.trim(),
                                  );
                                }
                              },
                              child: const Icon(Icons.arrow_circle_right_outlined),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

