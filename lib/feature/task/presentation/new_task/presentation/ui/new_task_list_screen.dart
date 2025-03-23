import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_ostad/app/app_router.dart';
import 'package:task_manager_ostad/data/models/task_count_by_status_model.dart';
import 'package:task_manager_ostad/data/models/task_count_model.dart';
import 'package:task_manager_ostad/data/models/task_list_by_status_model.dart';
import 'package:task_manager_ostad/data/service/network_caller.dart';
import 'package:task_manager_ostad/data/utills/urls.dart';
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


class NewTaskListScreen extends StatelessWidget {
  static const String name = '/new-task';

  const NewTaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: BlocProvider(
        create: (_) => NewTaskCubit(TaskRepository(sl()))..fetchAllData(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppRouter.navigateTo(context, AddNewTaskListScreen.name);
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
                count: model.sum.toString(), status:  getTaskStatusFromString(model.id),

            );
          },
        ),
      ),
    );
  }

  Widget _buildTaskListView(TaskListByStatusEntity taskListData, BuildContext context) {
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
