import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../app/service_locator.dart';
import '../../../../../common/presentation/widgets/center_circular_progress_indicator.dart';
import '../../../../../common/presentation/widgets/snack_bar_message.dart';
import '../../../../../common/presentation/widgets/task_card_status_widget.dart';
import '../../../../../common/presentation/widgets/task_item_widget.dart';
import '../../../../../common/presentation/widgets/tm_app_bar.dart';
import '../../../../data/repositories/task_repository.dart';
import '../../../../domain/entities/task_count_by_status_entity.dart';
import '../../../../domain/entities/task_count_entity.dart';
import '../../../../domain/entities/task_list_by_status_entity.dart';
import '../../../add_task/presentation/ui/add_new_task_list_screen.dart';
import '../blocs/cancel_task_cubit.dart';

class CancelTaskListScreen extends StatelessWidget {
  static const String name = '/cancel-task';

  const CancelTaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const TMAppBar(),
      body: BlocProvider(
        create: (_) => CancelTaskCubit(TaskRepository(sl()))..fetchAllData(),
        child: BlocBuilder<CancelTaskCubit, CancelTaskState>(
          builder: (context, state) {
            if (state is CancelTaskLoadingState) {
              return const CenterCircularProgressIndicator();
            } else if (state is CancelTaskFailureState) {
              return Center(child: Text(state.error));
            } else if (state is CancelTaskSuccessState) {
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
            await context.read<CancelTaskCubit>().deleteTask(id);
            showSnackBarMessage(context, 'Task deleted successfully');
          },
          onUpdateTaskStatus: (id, status) async {
            // Await the async update task status operation
            await context.read<CancelTaskCubit>().updateTaskStatus(id, status);
            showSnackBarMessage(context, 'Task status updated successfully');
          },
        );
      },
    );
  }
}
