part of 'new_task_cubit.dart';

abstract class NewTaskState extends Equatable {
  const NewTaskState();

  @override
  List<Object> get props => [];
}

class NewTaskInitialState extends NewTaskState {}

class NewTaskLoadingState extends NewTaskState {}

class NewTaskFailureState extends NewTaskState {
  const NewTaskFailureState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
class NewTaskSuccessState extends NewTaskState {
  const NewTaskSuccessState(this.taskListData,this.taskCountData);

  final TaskListByStatusEntity taskListData;
  final TaskCountByStatusEntity taskCountData;

  @override
  List<Object> get props => [taskListData,taskCountData];
}
