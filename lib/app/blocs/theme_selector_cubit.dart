import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/repository/theme_repository.dart';

class ThemeSelectorCubit extends Cubit<ThemeMode> {
  ThemeSelectorCubit(this.themeModeRepository) : super(ThemeMode.system);

  final ThemeModeRepository themeModeRepository;

  Future<void> changeThemeMode(ThemeMode mode) async {
    await themeModeRepository.saveThemeMode(mode.name);
    emit(mode);
  }

  Future<void> getPreSelectedTheme() async {
    final String preSelectedMode =
        await themeModeRepository.getThemeMode() ?? 'system';
    if (preSelectedMode == 'dark') {
      changeThemeMode(ThemeMode.dark);
    } else if (preSelectedMode == 'light') {
      changeThemeMode(ThemeMode.light);
    } else {
      changeThemeMode(ThemeMode.system);
    }
  }
}