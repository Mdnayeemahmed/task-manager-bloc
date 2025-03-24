part of 'add_new_task_cubit.dart';

abstract class AddNewTaskState extends Equatable {
  const AddNewTaskState();

  @override
  List<Object> get props => [];
}

class AddNewTaskInitialState extends AddNewTaskState {}

class AddNewTaskLoadingState extends AddNewTaskState {}

class AddNewTaskFailureState extends AddNewTaskState {
  const AddNewTaskFailureState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
class AddNewTaskSuccessState extends AddNewTaskState {
  const AddNewTaskSuccessState(this.taskListData,this.taskCountData);

  final TaskListByStatusEntity taskListData;
  final TaskCountByStatusEntity taskCountData;

  @override
  List<Object> get props => [taskListData,taskCountData];
}
//
// class AddNewTaskSuccessState extends AddNewTaskState {
//   const AddNewTaskSuccessState();
//
//   @override
//   List<Object> get props => [];
// }
