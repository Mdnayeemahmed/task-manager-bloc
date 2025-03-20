part of 'cancel_task_cubit.dart';

abstract class CancelTaskState extends Equatable {
  const CancelTaskState();

  @override
  List<Object> get props => [];
}

class CancelTaskInitialState extends CancelTaskState {}

class CancelTaskLoadingState extends CancelTaskState {}

class CancelTaskFailureState extends CancelTaskState {
  const CancelTaskFailureState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class CancelTaskSuccessState extends CancelTaskState {
  const CancelTaskSuccessState(this.taskListData,this.taskCountData);

  final TaskListByStatusEntity taskListData;
  final TaskCountByStatusEntity taskCountData;

  @override
  List<Object> get props => [taskListData,taskCountData];
}
