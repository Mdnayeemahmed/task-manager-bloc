import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../blocs/complete_task_cubit.dart';


class CompleteTaskListScreen extends StatefulWidget {
  static const String name = '/complete-task';

  const CompleteTaskListScreen({super.key});

  @override
  State<CompleteTaskListScreen> createState() => _CompleteTaskListScreenState();
}

class _CompleteTaskListScreenState extends State<CompleteTaskListScreen> {
  late CompleteTaskCubit _completeTaskCubit;

  @override
  void initState() {
    super.initState();
    _completeTaskCubit = CompleteTaskCubit(sl());
    _completeTaskCubit.fetchAllData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => _completeTaskCubit,
          ),
        ],
        child: BlocBuilder<CompleteTaskCubit, CompleteTaskState>(
          builder: (context, state) {
            if (state is CompleteTaskLoadingState) {
              return const CenterCircularProgressIndicator();
            } else if (state is CompleteTaskFailureState) {
              return Center(child: Text(state.error));
            } else if (state is CompleteTaskSuccessState) {
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

  Widget _buildTaskListView(TaskListByStatusEntity taskListData,
      BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: taskListData.taskList.length,
      itemBuilder: (context, index) {
        return TaskItems(
          taskModel: taskListData.taskList[index],
          onDeleteTask: (id) async {
            // Await the async delete task operation
            await context.read<CompleteTaskCubit>().deleteTask(id);
            showSnackBarMessage(context, 'Task deleted successfully');
          },
          onUpdateTaskStatus: (id, status) async {
            // Await the async update task status operation
            await context.read<CompleteTaskCubit>().updateTaskStatus(
                id, status);
            showSnackBarMessage(context, 'Task status updated successfully');
          },
        );
      },
    );
  }
}

