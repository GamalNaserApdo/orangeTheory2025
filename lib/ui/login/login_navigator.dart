import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otfksa2/ui/mian_tap_view/main_tab_view.dart';
// import 'package:your_app/ui/main_tab_view.dart'; // (اعمل import للشاشة الرئيسية)

class LoginNavigator {
  static void goToMainApp(BuildContext context) {
    // هنستخدم pushReplacement عشان اليوزر ميعرفش يرجع لصفحة اللوجن
    // عن طريق زر "Back"
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainTabView()),
    );
  }

  // ⭐️ دالة جديدة لعرض رسالة Toast
  static void showToast(String message, {bool isSuccess = true}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: isSuccess ? Colors.green.shade600 : Colors.red.shade600,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
