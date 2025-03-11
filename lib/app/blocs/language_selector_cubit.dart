import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/repository/language_repository.dart';

class LanguageSelectorCubit extends Cubit<Locale> {
  LanguageSelectorCubit(this.languageRepository) : super(const Locale('en'));

  final LanguageRepository languageRepository;

  Locale _currentLocale = const Locale('en');

  Locale get currentLocale => _currentLocale;

  List<Locale> get locales => const [Locale('en'), Locale('bn')];

  Future<void> getPreSelectedLocale() async {
    String langCode = await languageRepository.getLanguage();
    Locale language;
    if (langCode == '') {
      language = const Locale('en');
    } else {
      language = Locale(langCode);
    }
    emit(language);
  }

  Future<void> setLocale(Locale locale) async {
    _currentLocale = locale;
    await languageRepository.saveLanguage(locale.languageCode);
    emit(_currentLocale);
  }

  void toggleLocale() {
    if (_currentLocale == const Locale('en')) {
      setLocale(const Locale('bn'));
    } else {
      setLocale(const Locale('en'));
    }
  }
}