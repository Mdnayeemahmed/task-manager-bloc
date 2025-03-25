import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_ostad/app/app_router.dart';
import '../../../../../../app/service_locator.dart';
import '../../../../../common/presentation/widgets/center_circular_progress_indicator.dart';
import '../../../../../common/presentation/widgets/snack_bar_message.dart';
import '../../../../../common/presentation/widgets/task_card_status_widget.dart';
import '../../../../../common/presentation/widgets/task_item_widget.dart';
import '../../../../../common/presentation/widgets/tm_app_bar.dart';
import '../../../../data/repositories/task_repository.dart';
import '../../../../domain/entities/task_count_by_status_entity.dart';
import '../../../../domain/entities/task_list_by_status_entity.dart';
import '../../../add_task/presentation/ui/add_new_task_list_screen.dart';
import '../blocs/add_new_task_cubit.dart';

class NewTaskListScreen extends StatefulWidget {
  static const String name = '/new-task';

  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {

  late NewTaskCubit _newTaskBloc;

  @override
  void initState() {
    super.initState();
    _newTaskBloc = NewTaskCubit(sl());
    _newTaskBloc.fetchAllData();
  }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
// print("yes changed");
//     // Ensure that you access the NewTaskCubit from the context rather than creating a new instance
//     context.read<NewTaskCubit>().fetchAllData();
//   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
            _newTaskBloc
          ),
        ],
        child: BlocListener<NewTaskCubit, NewTaskState>(
          listener: (context, state) {
            // if (state is NewTaskSuccessState) {
            //   // Refresh data when task is successfully added or updated
            //   context.read<NewTaskCubit>().fetchAllData();
            // }

            // TODO: implement listener
          },
          child: BlocBuilder<NewTaskCubit, NewTaskState>(
            builder: (context, state) {
              if (state is NewTaskLoadingState) {
                return const CenterCircularProgressIndicator();
              } else if (state is NewTaskFailureState) {
                return Center(child: Text(state.error));
              } else if (state is NewTaskSuccessState) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTaskCardStatus(state.taskCountData),
                      _buildTaskListView(state.taskListData, context),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await AppRouter.navigateTo(
              context, AddNewTaskListScreen.name);
          if (result == true) {
            _newTaskBloc.fetchAllData();

            // context.read<NewTaskCubit>().fetchAllData();
          }
          // AppRouter.navigateTo(context, AddNewTaskListScreen.name);

          // AppRouter.navigateTo(context, AddNewTaskListScreen.name)..;
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskCardStatus(TaskCountByStatusEntity taskCountData) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: taskCountData.taskByStatusList?.length ?? 0,
          itemBuilder: (context, index) {
            final model = taskCountData.taskByStatusList![index];
            return TaskCardStatusWidget(
              title: model.id ?? '',
              count: model.sum.toString(),
              status: getTaskStatusFromString(model.id),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTaskListView(TaskListByStatusEntity taskListData,
      BuildContext context) {

    if (taskListData.taskList.isEmpty) {
      return const Center(
        child: Text(
          'No task found',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: taskListData.taskList.length,
      itemBuilder: (context, index) {
        return TaskItems(
          taskModel: taskListData.taskList[index],
          onDeleteTask: (id) async {
            // Await the async delete task operation
            await context.read<NewTaskCubit>().deleteTask(id);
            showSnackBarMessage(context, 'Task deleted successfully');
          },
          onUpdateTaskStatus: (id, status) async {
            // Await the async update task status operation
            await context.read<NewTaskCubit>().updateTaskStatus(id, status);
            showSnackBarMessage(context, 'Task status updated successfully');
          },
        );
      },
    );
  }
}
