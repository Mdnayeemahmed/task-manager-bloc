part of 'progress_task_cubit.dart';

abstract class ProgressTaskState extends Equatable {
  const ProgressTaskState();

  @override
  List<Object> get props => [];
}

class ProgressTaskInitialState extends ProgressTaskState {}

class ProgressTaskLoadingState extends ProgressTaskState {}

class ProgressTaskFailureState extends ProgressTaskState {
  const ProgressTaskFailureState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class ProgressTaskSuccessState extends ProgressTaskState {
  const ProgressTaskSuccessState(this.taskListData,this.taskCountData);

  final TaskListByStatusEntity taskListData;
  final TaskCountByStatusEntity taskCountData;

  @override
  List<Object> get props => [taskListData,taskCountData];
}
