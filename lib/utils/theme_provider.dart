import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:otfksa2/utils/app_them.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  ThemeMode _themeMode = ThemeMode.light;
  
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  
  ThemeProvider() {
    _loadThemeMode();
  }
  
  // تحميل الثيم المحفوظ
  Future<void> _loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedTheme = prefs.getString(_themeKey);
      if (savedTheme != null) {
        _themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
        notifyListeners();
      }
    } catch (e) {
      print('Error loading theme: $e');
    }
  }
  
  // تبديل الثيم
  Future<void> toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    
    // حفظ الاختيار
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, isDark ? 'dark' : 'light');
    } catch (e) {
      print('Error saving theme: $e');
    }
  }
  
  // الحصول على الثيم المناسب
  ThemeData getTheme() {
    return _themeMode == ThemeMode.dark 
        ? AppTheme.darkTheme 
        : AppTheme.lightTheme;
  }
}

