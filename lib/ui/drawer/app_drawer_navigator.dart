import 'package:flutter/material.dart';
import 'package:otfksa2/utils/app_routes.dart';

class AppDrawerNavigator {
  static void goToSettings(BuildContext context) {
    // 1. اقفل الـ Drawer الأول
    Navigator.pop(context);

    // 2. اذهب لشاشة الإعدادات باستخدام Named Route
    Navigator.pushNamed(context, AppRoutes.settingsRouteName);
  }

  static void doLogout(BuildContext context) {
    // 1. استخدم الدالة دي عشان تروح للوجن وتمسح كل اللي فات
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.loginRouteName,
      (Route<dynamic> route) => false,
    );
  }

  // ... (دوال goToSettings و doLogout)

  // ⭐️ دوال Business الجديدة
  static void goToPackages(BuildContext context) {
    Navigator.pop(context); // إغلاق الـ Drawer
    Navigator.pushNamed(context, AppRoutes.packagesRouteName);
  }

  static void goToStudios(BuildContext context) {
    Navigator.pop(context); // إغلاق الـ Drawer
    Navigator.pushNamed(context, AppRoutes.studiosRouteName);
  }

  static void goToCountriesCities(BuildContext context) {
    Navigator.pop(context); // إغلاق الـ Drawer
    Navigator.pushNamed(context, AppRoutes.countriesCitiesRouteName);
  }
}
