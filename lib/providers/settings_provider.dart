import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';

class SettingsProvider extends ChangeNotifier {
  Locale _locale = const Locale('vi');
  ThemeMode _themeMode = ThemeMode.light;

  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;

  void setLanguage(String code) {
    _locale = Locale(code);
    notifyListeners();
  }

  void setDark(bool value) {
    _themeMode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Lấy chuỗi theo ngôn ngữ hiện tại
  String t(String key, [Map<String, String>? params]) =>
      AppStrings.get(_locale.languageCode, key, params);
}
