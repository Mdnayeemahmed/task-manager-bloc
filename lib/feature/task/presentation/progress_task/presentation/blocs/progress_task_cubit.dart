import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


import '../../../../../../core/domain/entities/failure.dart';
import '../../../../data/repositories/task_repository.dart';
import '../../../../domain/entities/task_count_by_status_entity.dart';
import '../../../../domain/entities/task_list_by_status_entity.dart';

part 'progress_task_state.dart';

class ProgressTaskCubit extends Cubit<ProgressTaskState> {
  final TaskRepository taskRepository;

  ProgressTaskCubit(this.taskRepository) : super(ProgressTaskInitialState());

  Future<void> fetchAllData() async {
    try {
      emit(ProgressTaskLoadingState());
      final taskCountResult = await _getTaskCountByStatus();
      final cancelTaskListResult = await _getCancelTaskList();

      taskCountResult.fold(
            (failure) {
          emit(ProgressTaskFailureState(failure.message));
        },
            (taskCount) {
          cancelTaskListResult.fold(
                (failure) {
              emit(ProgressTaskFailureState(failure.message));
            },
                (cancelTaskList) {
              emit(ProgressTaskSuccessState(cancelTaskList, taskCount));
            },
          );
        },
      );
    } catch (e) {
      emit(ProgressTaskFailureState(e.toString()));
    }
  }

  Future<Either<Failure, TaskCountByStatusEntity>> _getTaskCountByStatus() async {
    final result = await taskRepository.getTaskCount();

    return result;
  }

  Future<Either<Failure, TaskListByStatusEntity>> _getCancelTaskList() async {
    final result = await taskRepository.getTaskListByStatus('Progress');

    return result;
  }

  Future<void> deleteTask(String id) async {
    final result = await taskRepository.deleteTask(id);

    result.fold(
          (failure) {
        emit(ProgressTaskFailureState(failure.message));
      },
          (success) {
        if (success) {
          fetchAllData(); // Refresh task list and task count after deletion
        }
      },
    );
  }

  Future<void> updateTaskStatus(String id, String status) async {
    final result = await taskRepository.updateTask(id, status);

    result.fold(
          (failure) {
        emit(ProgressTaskFailureState(failure.message));
      },
          (success) {
        if (success) {
          fetchAllData(); // Refresh task list and task count after status update
        }
      },
    );
  }
}