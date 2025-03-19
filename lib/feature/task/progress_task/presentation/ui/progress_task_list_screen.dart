import 'package:flutter/material.dart';
import 'package:task_manager_ostad/data/models/task_count_by_status_model.dart';
import 'package:task_manager_ostad/data/models/task_count_model.dart';
import 'package:task_manager_ostad/data/models/task_list_by_status_model.dart';
import 'package:task_manager_ostad/data/service/network_caller.dart';
import 'package:task_manager_ostad/data/utills/urls.dart';
import 'package:task_manager_ostad/feature/new_task/presentation/ui/add_new_task_list_screen.dart';
import 'package:task_manager_ostad/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager_ostad/ui/widgets/screen_background.dart';
import 'package:task_manager_ostad/ui/widgets/snack_bar_message.dart';
import '../../../../ui/widgets/task_card_status_widget.dart';
import '../../../common/presentation/widgets/task_item_widget.dart';
import '../../../../ui/widgets/tm_app_bar.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  bool _getTaskCountByStatusInProgress = false;
  bool _getProgressTaskListInProgress = false;
  TaskCountByStatusModel? taskCountByStatusModel;
  TaskListByStatusModel? progressTaskListModel;

  @override
  void initState() {
    super.initState();
    _fetchAllData();
    // _getTaskCountByStatus();
    // _getProgressTaskList();
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
                    visible: _getProgressTaskListInProgress == false,
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
                itemCount:
                    taskCountByStatusModel?.taskByStatusList?.length ?? 0,
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
        itemCount: progressTaskListModel?.taskList?.length ?? 0,
        itemBuilder: (context, index) {
          return TaskItems(
            taskModel: progressTaskListModel!.taskList![index],
            onDeleteTask: _deleteTask,
            onUpdateTaskStatus: _updateTaskStatus,
          );
        });
  }

  Future<void> _fetchAllData() async {
    try {
      await _getTaskCountByStatus();
      await _getProgressTaskList();
    } catch (e) {
      showSnackBarMessage(context, e.toString());
    }
  }

  Future<void> _deleteTask(String id) async {
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.deleteTaskItemUrl(id));

    if (response.isSuccess) {
      _fetchAllData();
      showSnackBarMessage(context, 'task delete successful');
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
  }

  Future<void> _updateTaskStatus(String id, String status) async {
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.updateTaskUrl(id, status));

    if (response.isSuccess) {
      _fetchAllData();
      showSnackBarMessage(context, 'task status updated successfully');
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
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

  Future<void> _getProgressTaskList() async {
    _getProgressTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskListByStatusUrl('Progress'));
    if (response.isSuccess) {
      progressTaskListModel =
          TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
    _getProgressTaskListInProgress = false;
    setState(() {});
  }
}
