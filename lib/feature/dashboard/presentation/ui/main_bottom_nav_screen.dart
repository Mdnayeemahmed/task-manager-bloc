import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../task/presentation/cancel_task/presentation/ui/cancel_task_list_screen.dart';
import '../../../task/presentation/complete_task/presentation/ui/complete_task_list_screen.dart';
import '../../../task/presentation/new_task/presentation/ui/new_task_list_screen.dart';
import '../../../task/presentation/progress_task/presentation/ui/progress_task_list_screen.dart';
import '../blocs/bottom_nav_cubit.dart';

class MainBottomNavScreen extends StatelessWidget {
  const MainBottomNavScreen({super.key});
  static const String name = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavCubit(),
      child: Scaffold(
        body: BlocBuilder<BottomNavCubit, BottomNavState>(
          builder: (context, state) {
            final selectedIndex = state.selectedIndex;

            // Define the screens
            const List<Widget> screens = [
              NewTaskListScreen(),
              ProgressTaskListScreen(),
              CompleteTaskListScreen(),
              CancelTaskListScreen(),
            ];

            return screens[selectedIndex];
          },
        ),
        bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNavState>(
          builder: (context, state) {
            return NavigationBar(
              selectedIndex: state.selectedIndex,
              onDestinationSelected: (int index) {
                // Call the cubit to update the selected tab
                context.read<BottomNavCubit>().selectTab(index);
              },
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.new_label_outlined), label: 'New'),
                NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
                NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
                NavigationDestination(
                    icon: Icon(Icons.cancel_outlined), label: 'Cancelled'),
              ],
            );
          },
        ),
      ),
    );
  }
}
