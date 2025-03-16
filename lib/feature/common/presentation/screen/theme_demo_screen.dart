import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/blocs/theme_selector_cubit.dart';
import '../../../../core/widgets/spacing.dart';

class ThemeDemoScreen extends StatefulWidget {
  const ThemeDemoScreen({super.key});

  static const String name = '/themeDemo';

  @override
  State<ThemeDemoScreen> createState() => _ThemeDemoScreenState();
}

class _ThemeDemoScreenState extends State<ThemeDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dark mode'),
                BlocBuilder<ThemeSelectorCubit, ThemeMode>(
                  builder: (context, themeMode) {
                    return ToggleButtons(
                      isSelected: _getSelectedList(themeMode),
                      onPressed: onPressThemeToggle,
                      children:
                      ThemeMode.values.map((e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(e.name),
                      )).toList(),
                    );
                  },
                ),
              ],
            ),
            verticalSpacing(32),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: 'demo'
              ),
            ),
            verticalSpacing(24),
            TextButton(onPressed: () {}, child: Text('Button')),
            verticalSpacing(24),
            ElevatedButton(onPressed: () {}, child: Text('Elevated'))
          ],
        ),
      ),
    );
  }

  List<bool> _getSelectedList(ThemeMode themeMode) {
    List<bool> list = [false, false, false];
    if (themeMode == ThemeMode.system) {
      list[0] = true;
    } else if (themeMode == ThemeMode.light) {
      list[1] = true;
    } else {
      list[2] = true;
    }
    return list;
  }

  void onPressThemeToggle(int index) {
    if (index == 0) {
      context.read<ThemeSelectorCubit>().changeThemeMode(ThemeMode.system);
    } else if (index == 1) {
      context.read<ThemeSelectorCubit>().changeThemeMode(ThemeMode.light);
    } else {
      context.read<ThemeSelectorCubit>().changeThemeMode(ThemeMode.dark);
    }
  }
}