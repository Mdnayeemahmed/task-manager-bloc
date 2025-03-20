import 'package:dartz/dartz.dart';

import '../../../../../../core/domain/entities/failure.dart';
import '../../../../data/repositories/task_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

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
          (success) => emit(const AddNewTaskSuccessState()),
    );
  }

}

