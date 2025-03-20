import 'package:task_manager_ostad/feature/task/data/models/task_list_by_status_model.dart';
import 'package:task_manager_ostad/feature/task/data/models/task_list_model.dart';

import '../../domain/entities/task_entity.dart';

class TaskListByStatusEntity {
  final String status;
  final List<TaskEntity> taskList;

  TaskListByStatusEntity({required this.status, required this.taskList});
}
extension TaskListByStatusModelMapper on TaskListByStatusModel {
  TaskListByStatusEntity toEntity() {
    return TaskListByStatusEntity(
      status: status ?? '',
      taskList: taskList?.map((model) => model.toEntity()).toList() ?? [],
    );
  }
}

extension TaskListByStatusEntityMapper on TaskListByStatusEntity {
  TaskListByStatusModel toModel() {
    return TaskListByStatusModel(
      status: status,
      taskList: taskList.map((entity) => entity.toModel()).toList(),
    );
  }
}
