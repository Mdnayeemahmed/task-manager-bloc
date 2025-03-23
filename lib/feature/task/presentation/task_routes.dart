import 'package:go_router/go_router.dart';
import 'package:task_manager_ostad/feature/auth/presentation/ui/screens/sign_in_screen.dart';
import 'package:task_manager_ostad/feature/auth/presentation/ui/screens/sign_up_screen.dart';
import 'package:task_manager_ostad/feature/task/presentation/add_task/presentation/ui/add_new_task_list_screen.dart';
import 'package:task_manager_ostad/feature/task/presentation/cancel_task/presentation/ui/cancel_task_list_screen.dart';
import 'package:task_manager_ostad/feature/task/presentation/complete_task/presentation/ui/complete_task_list_screen.dart';
import 'package:task_manager_ostad/feature/task/presentation/new_task/presentation/ui/new_task_list_screen.dart';
import 'package:task_manager_ostad/feature/task/presentation/progress_task/presentation/ui/progress_task_list_screen.dart';

class TaskRoutes {
  static List<GoRoute> routes = [
    GoRoute(
      path: AddNewTaskListScreen.name,
      name: AddNewTaskListScreen.name,
      builder: (context, state) {
        return  const AddNewTaskListScreen();
      },
    ),
    GoRoute(
      path: CancelTaskListScreen.name,
      name: CancelTaskListScreen.name,
      builder: (context, state) {
        return  const CancelTaskListScreen();
      },
    ),
    GoRoute(
      path: NewTaskListScreen.name,
      name: NewTaskListScreen.name,
      builder: (context, state) {
        return  const NewTaskListScreen();
      },
    ),
    GoRoute(
      path: CompleteTaskListScreen.name,
      name: CompleteTaskListScreen.name,
      builder: (context, state) {
        return  const CompleteTaskListScreen();
      },
    ),
    GoRoute(
      path: ProgressTaskListScreen.name,
      name: ProgressTaskListScreen.name,
      builder: (context, state) {
        return  const ProgressTaskListScreen();
      },
    ),
    // GoRoute(
    //   path: SignUpScreen.name,
    //   name: SignUpScreen.name,
    //   builder: (context, state) {
    //     return  const SignUpScreen();
    //   },
    // ),
  ];
}