import 'package:dartz/dartz.dart';

import '../../../../core/domain/data/model/api_failure.dart';
import '../../../../core/domain/entities/failure.dart';
import '../../../../core/network_executor/network_executor.dart';
import '../../domain/entities/task_count_by_status_entity.dart';
import '../../domain/entities/task_list_by_status_entity.dart';
import '../models/task_count_by_status_model.dart';
import '../models/task_list_by_status_model.dart';

class TaskRepository {
  TaskRepository(
      this._networkExecutor,
      );

  final String _taskBaseUrl = 'listTaskByStatus';
  final String _updateTaskBaseUrl = 'updateTaskStatus';
  final String _deleteTaskBaseUrl = 'deleteTask';
  final String _taskCountByStatusUrl = 'taskStatusCount';


  final NetworkExecutor _networkExecutor;

  Future<Either<Failure, TaskListByStatusEntity>> getTaskListByStatus(String status) async {
    String url = "$_taskBaseUrl/$status";

    final response = await _networkExecutor.getRequest(path: url);

    final responseBody = response.body as Map<String, dynamic>;

    if (responseBody['status'] == 'success') {
      final taskListByStatusModel = TaskListByStatusModel.fromJson(responseBody);
      return Right(taskListByStatusModel.toEntity());
    } else {
      return Left(ApiFailure.fromJson(response.body).toEntity());
    }
  }


  Future<Either<Failure, TaskCountByStatusEntity>> getTaskCount() async {
    final response = await _networkExecutor.getRequest(path: _taskCountByStatusUrl);

    final responseBody = response.body as Map<String, dynamic>;
    if (responseBody['status'] == 'success') {
      final taskCountModel = TaskCountByStatusModel.fromJson(responseBody);
      final taskCountEntity = taskCountModel.toEntity();

      return Right(taskCountEntity);
    } else {
      return Left(ApiFailure.fromJson(response.body).toEntity());
    }
  }


  Future<Either<Failure, bool>> updateTask(
      String id,String status) async {
    String url = "$_updateTaskBaseUrl/$id/$status";


    final response = await _networkExecutor.getRequest(
      path: url,
    );


    final responseBody = response.body as Map<String, dynamic>;
    if (responseBody['status'] == 'success') {
      return const Right(true);
    } else {
      return Left(ApiFailure.fromJson(response.body).toEntity());
    }
  }

  Future<Either<Failure, bool>> deleteTask(
      String id) async  {
    String url = "$_deleteTaskBaseUrl/$id";


    final response = await _networkExecutor.getRequest(
      path: url,
    );


    final responseBody = response.body as Map<String, dynamic>;
    if (responseBody['status'] == 'success') {

      return const Right(true);
    } else {
      return Left(ApiFailure.fromJson(response.body).toEntity());
    }
  }


  Future<Either<Failure, bool>> addNewTask(
      String title,String description) async  {
    String url = "$_deleteTaskBaseUrl/$id";


    final response = await _networkExecutor.postRequest(
      path: url,
      data: {
        "title": title,
        "description":description,
        "status": "New",
      }
    );


    final responseBody = response.body as Map<String, dynamic>;
    if (responseBody['status'] == 'success') {

      return const Right(true);
    } else {
      return Left(ApiFailure.fromJson(response.body).toEntity());
    }
  }
}
