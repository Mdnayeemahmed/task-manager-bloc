import 'package:task_manager_ostad/feature/task/domain/entities/task_count_entity.dart';

class TaskCountByStatusEntity {
  final String status;
  final List<TaskCountEntity> taskByStatusList;

  TaskCountByStatusEntity({
    required this.status,
    required this.taskByStatusList,
  });
}