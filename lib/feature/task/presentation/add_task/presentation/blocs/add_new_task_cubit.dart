import 'package:dartz/dartz.dart';

import '../../../../../../core/domain/entities/failure.dart';
import '../../../../data/repositories/task_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/task_count_by_status_entity.dart';
import '../../../../domain/entities/task_list_by_status_entity.dart';

part 'add_new_task_state.dart';

class AddNewTaskCubit extends Cubit<AddNewTaskState> {
  final TaskRepository taskRepository;

  AddNewTaskCubit(this.taskRepository) : super(AddNewTaskInitialState());

  Future<void> addNewTask(String title, String description) async {
    emit(AddNewTaskLoadingState());

    // Call repository to add a new task
    final Either<Failure, bool> result =
        await taskRepository.addNewTask(title, description);

    result.fold(
      (failure) => emit(AddNewTaskFailureState(failure.message)),
      (success) {
        if (success) {
          fetchAllData(); // Refresh task list and task count after status update
        }
      },
    );
  }

  Future<void> fetchAllData() async {
    try {
      emit(AddNewTaskLoadingState());
      final taskCountResult = await _getTaskCountByStatus();
      final cancelTaskListResult = await _getCancelTaskList();

      taskCountResult.fold(
        (failure) {
          emit(AddNewTaskFailureState(failure.message));
        },
        (taskCount) {
          cancelTaskListResult.fold(
            (failure) {
              emit(AddNewTaskFailureState(failure.message));
            },
            (cancelTaskList) {
              emit(AddNewTaskSuccessState(cancelTaskList, taskCount));
            },
          );
        },
      );
    } catch (e) {
      emit(AddNewTaskFailureState(e.toString()));
    }
  }

  Future<Either<Failure, TaskCountByStatusEntity>>
      _getTaskCountByStatus() async {
    final result = await taskRepository.getTaskCount();

    return result;
  }

  Future<Either<Failure, TaskListByStatusEntity>> _getCancelTaskList() async {
    final result = await taskRepository.getTaskListByStatus('New');

    return result;
  }
}
