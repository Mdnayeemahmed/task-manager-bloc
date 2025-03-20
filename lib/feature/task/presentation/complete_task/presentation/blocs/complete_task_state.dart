part of 'complete_task_cubit.dart';

abstract class CompleteTaskState extends Equatable {
  const CompleteTaskState();

  @override
  List<Object> get props => [];
}

class CompleteTaskInitialState extends CompleteTaskState {}

class CompleteTaskLoadingState extends CompleteTaskState {}

class CompleteTaskFailureState extends CompleteTaskState {
  const CompleteTaskFailureState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class CompleteTaskSuccessState extends CompleteTaskState {
  const CompleteTaskSuccessState(this.taskListData,this.taskCountData);

  final TaskListByStatusEntity taskListData;
  final TaskCountByStatusEntity taskCountData;

  @override
  List<Object> get props => [taskListData,taskCountData];
}


