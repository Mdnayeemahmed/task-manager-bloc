import 'package:flutter/material.dart';

import '../../../task/cancel_task/presentation/ui/cancel_task_list_screen.dart';
import '../../../task/complete_task/presentation/ui/complete_task_list_screen.dart';
import '../../../task/new_task/presentation/ui/new_task_list_screen.dart';
import '../../../task/progress_task/presentation/ui/progress_task_list_screen.dart';


class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});
  static const String name = '/home';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    NewTaskListScreen(),
    ProgressTaskListScreen(),
    CompleteTaskListScreen(),
    CancelTaskListScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            _selectedIndex = index;
            setState(() {});
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.new_label_outlined), label: 'New'),
            NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
            NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
            NavigationDestination(
                icon: Icon(Icons.cancel_outlined), label: 'Cancelled'),
          ]),
    );
  }
}
