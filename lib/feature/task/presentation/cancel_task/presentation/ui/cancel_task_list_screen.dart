import 'package:flutter/material.dart';
import 'package:task_manager_ostad/data/models/task_count_by_status_model.dart';
import 'package:task_manager_ostad/data/models/task_count_model.dart';
import 'package:task_manager_ostad/data/models/task_list_by_status_model.dart';
import 'package:task_manager_ostad/data/service/network_caller.dart';
import 'package:task_manager_ostad/data/utills/urls.dart';

import '../../../common/presentation/widgets/center_circular_progress_indicator.dart';
import '../../../common/presentation/widgets/screen_background.dart';
import '../../../common/presentation/widgets/snack_bar_message.dart';
import '../../../common/presentation/widgets/task_card_status_widget.dart';
import '../../../common/presentation/widgets/task_item_widget.dart';
import '../../../common/presentation/widgets/tm_app_bar.dart';

class CancelTaskListScreen extends StatefulWidget {
  const CancelTaskListScreen({super.key});

  @override
  State<CancelTaskListScreen> createState() => _CancelTaskListScreenState();
}

class _CancelTaskListScreenState extends State<CancelTaskListScreen> {
  bool _getTaskCountByStatusInProgress = false;
  bool _getCancelTaskListInProgress = false;
  TaskCountByStatusModel? taskCountByStatusModel;
  TaskListByStatusModel? cancelTaskListModel;

  @override
  void initState() {
    super.initState();
    _fetchAllData();
    // _getTaskCountByStatus();
    // _getCancelTaskList();
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
                    visible: _getCancelTaskListInProgress == false,
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
        itemCount: cancelTaskListModel?.taskList?.length ?? 0,
        itemBuilder: (context, index) {
          return TaskItems(
            taskModel: cancelTaskListModel!.taskList![index],
            onDeleteTask: _deleteTask,
            onUpdateTaskStatus: _updateTaskStatus,
          );
        });
  }

  Future<void> _fetchAllData() async {
    try {
      await _getTaskCountByStatus();
      await _getCancelTaskList();
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

  Future<void> _getCancelTaskList() async {
    _getCancelTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskListByStatusUrl('Canceled'));
    if (response.isSuccess) {
      cancelTaskListModel =
          TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
    _getCancelTaskListInProgress = false;
    setState(() {});
  }
}
