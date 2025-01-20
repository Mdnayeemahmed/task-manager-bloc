import 'package:flutter/material.dart';
import 'package:task_manager_ostad/ui/screens/add_new_task_list_screen.dart';
import 'package:task_manager_ostad/ui/widgets/screen_background.dart';
import '../widgets/task_card_status_widget.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/tm_app_bar.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTaskCardStatus(),
              _buildTaskListView(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewTaskListScreen.name);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskCardStatus() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            TaskCardStatusWidget(
              title: 'New Task',
              count: '12',
            ),
            SizedBox(
              width: 24,
            ),
            TaskCardStatusWidget(
              title: 'Progress',
              count: '12',
            ),
            SizedBox(
              width: 24,
            ),
            TaskCardStatusWidget(
              title: 'Completed',
              count: '12',
            ),
            SizedBox(
              width: 24,
            ),
            TaskCardStatusWidget(
              title: 'Canceled',
              count: '12',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskListView() {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: 10,
        itemBuilder: (context, index) {
          return  const TaskItemWidget(text: 'New',color: Colors.blue,);
        });
  }
}
