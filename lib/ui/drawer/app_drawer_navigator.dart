import 'package:flutter/material.dart';
import 'package:otfksa2/utils/app_routes.dart';
// import 'package:your_app/ui/login/login_view.dart';
// import 'package:your_app/ui/settings/settings_view.dart'; // (شاشة جديدة لو هتعملها)
import "package:otfksa2/utils/app_routes.dart";

class AppDrawerNavigator {
  static void goToSettings(BuildContext context) {
    // 1. اقفل الـ Drawer الأول
    Navigator.pop(context);

    // 2. اذهب لشاشة الإعدادات باستخدام Named Route
    Navigator.pushNamed(
      context,
      AppRoutes.settingsRouteName, // ✅ استخدام المسار المسمى
    );
    print("Navigator: Navigating to Settings...");
  }

  static void doLogout(BuildContext context) {
    // 1. استخدم الدالة دي عشان تروح للوجن وتمسح كل اللي فات
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.loginRouteName, // <-- 1. استخدم المتغير بدل النص
      (Route<dynamic> route) => false, // 2. الشرط (false معناه امسح كله)
    );
    print("Navigator: Logging out and navigating to Login...");
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
