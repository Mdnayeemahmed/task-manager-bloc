import 'package:flutter/material.dart';
import 'package:task_manager_ostad/data/models/task_count_by_status_model.dart';
import 'package:task_manager_ostad/data/models/task_count_model.dart';
import 'package:task_manager_ostad/data/models/task_list_by_status_model.dart';
import 'package:task_manager_ostad/data/service/network_caller.dart';
import 'package:task_manager_ostad/data/utills/urls.dart';
import 'package:task_manager_ostad/ui/screens/add_new_task_list_screen.dart';
import 'package:task_manager_ostad/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager_ostad/ui/widgets/screen_background.dart';
import 'package:task_manager_ostad/ui/widgets/snack_bar_message.dart';
import '../widgets/task_card_status_widget.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/tm_app_bar.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  bool _getTaskCountByStatusInProgress = false;
  bool _getNewTaskListInProgress=false;
  TaskCountByStatusModel? taskCountByStatusModel;
  TaskListByStatusModel? newTaskListModel;

  @override
  void initState() {
    super.initState();
    _getTaskCountByStatus();
    _getNewTaskList();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTaskCardStatus(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Visibility(
                    visible: _getNewTaskListInProgress==false,
                    replacement: const CenterCircularProgressIndicator(),
                    child: _buildTaskListView()),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewTaskListScreen.name);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskCardStatus() {
    return Visibility(
      visible: _getTaskCountByStatusInProgress == false,
      replacement: const CenterCircularProgressIndicator(),
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: taskCountByStatusModel?.taskByStatusList?.length ?? 0,
                itemBuilder: (context, index) {
              final TaskCountModel model =
                  taskCountByStatusModel!.taskByStatusList![index];
              return TaskCardStatusWidget(
                title: model.sId ?? '',
                count: model.sum.toString(),
              );
            }),
          )),
    );
  }

  Widget _buildTaskListView() {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: newTaskListModel?.taskList?.length ?? 0,
        itemBuilder: (context, index) {
          return TaskItemWidget(
            taskModel: newTaskListModel!.taskList![index],

          );
        });
  }

  Future<void> _getTaskCountByStatus() async {
    _getTaskCountByStatusInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskCountByStatusUrl);
    if (response.isSuccess) {
      taskCountByStatusModel =
          TaskCountByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
    _getTaskCountByStatusInProgress = false;
    setState(() {});
  }

  Future<void> _getNewTaskList() async {
    _getNewTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.taskListByStatusUrl('New'));
    if (response.isSuccess) {
      newTaskListModel =
          TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
    _getNewTaskListInProgress = false;
    setState(() {});
  }
}
