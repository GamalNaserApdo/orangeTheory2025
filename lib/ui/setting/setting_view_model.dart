import 'package:flutter/material.dart';
import 'package:otfksa2/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsViewModel extends ChangeNotifier {
  static const Color primaryColor = Color(0xFFF37B2D);

  // ⭐️ الخاصية الجديدة
  String _profileImageUrl = 'https://i.pravatar.cc/150?img=5'; // صورة محاكاة
  String get profileImageUrl => _profileImageUrl;

  // ⭐️ المتغيرات الناقصة: التنبيهات
  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  // دالة محاكاة لتغيير الصورة
  Future<void> pickAndUploadImage() async {
    // هنا يكون لوجيك فتح المعرض/الكاميرا ورفع الصورة

    // محاكاة التحديث بعد الرفع
    _profileImageUrl =
        'https://i.pravatar.cc/150?img=${DateTime.now().millisecond % 50}';
    print('Profile image updated.');
    notifyListeners();
  }

  // ⭐️ الدوال الناقصة: تبديل التنبيهات
  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    // هنا ممكن تضيف لوجيك لتعديل تفضيلات التنبيهات في قاعدة البيانات
    print('Notifications Toggled: $value');
    notifyListeners();
  }

  // دالة لحفظ الإعدادات بشكل عام (إذا كان هناك زر حفظ)
  Future<void> saveSettings() async {
    // ... لوجيك حفظ الإعدادات
    print('Settings saved.');
  }
}
