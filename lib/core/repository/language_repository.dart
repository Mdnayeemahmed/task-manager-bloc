import 'package:shared_preferences/shared_preferences.dart';

abstract class LanguageRepository {
  Future<void> saveLanguage(String language);

  Future<String> getLanguage();
}

class LanguageRepositoryImpl extends LanguageRepository {
  final String _languageKey = 'language';

  @override
  Future<String> getLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? lang = sharedPreferences.getString(_languageKey);
    return lang ?? '';
  }

  @override
  Future<void> saveLanguage(String language) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_languageKey, language);
  }
}