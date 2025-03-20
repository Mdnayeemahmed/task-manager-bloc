import 'package:task_manager_ostad/feature/task/data/models/task_list_model.dart';

class TaskListByStatusModel {
  String? status;
  List<TaskListModel>? taskList;

  TaskListByStatusModel({this.status, this.taskList});

  // Factory constructor to create an instance from JSON
  TaskListByStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <TaskListModel>[];
      json['data'].forEach((v) {
        taskList!.add(TaskListModel.fromJson(v));
      });
    }
  }

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskList != null) {
      data['data'] = taskList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


