import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeModeRepository {
  Future<String?> getThemeMode();

  Future<void> saveThemeMode(String themeMode);
}

class ThemeModeRepositoryImpl extends ThemeModeRepository {
  final String _themeModeKey = 'theme-mode';

  @override
  Future<String?> getThemeMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? themeMode = sharedPreferences.getString(_themeModeKey);
    return themeMode;
  }

  @override
  Future<void> saveThemeMode(String themeMode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_themeModeKey, themeMode);
  }
}