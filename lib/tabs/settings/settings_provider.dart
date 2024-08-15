import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String language = 'en';
  SettingsProvider() {
    loadSettings();
  }
  bool get isDark => themeMode == ThemeMode.dark;
  Future<void> saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'themeMode', themeMode == ThemeMode.dark ? 'dark' : 'light');
    await prefs.setString('language', language);
  }

  Future<void> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedTheme = prefs.getString('themeMode');
    String? savedLanguage = prefs.getString('language');
    if (savedTheme != null) {
      themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
    if (savedLanguage != null) {
      language = savedLanguage;
    }
    notifyListeners();
  }

  void changeTheme(ThemeMode selectedTheme) {
    themeMode = selectedTheme;
    saveSettings();
    notifyListeners();
  }

  void changLanguge(String selectedLanguage) {
    language = selectedLanguage;
    saveSettings();
    notifyListeners();
  }
}
