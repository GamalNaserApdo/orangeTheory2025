import 'package:flutter/material.dart';
import 'package:otfksa2/ui/login/login_navigator.dart';
// import 'login_navigator.dart'; // (هنعمله في الخطوة 3)

class LoginViewModel extends ChangeNotifier {
  static const Color primaryColor = Color(0xFFF37B2D);

  final TextEditingController emailController = TextEditingController(
    text: "admin@orangetheory.com",
  );
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<void> onLoginPressed(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null; // مسح أي خطأ سابق
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    String email = emailController.text;
    String password = passwordController.text;

    if (email == "admin@orangetheory.com" && password.isNotEmpty) {
      _isLoading = false;
      notifyListeners();

      LoginNavigator.showToast(
        "Login successful. Welcome back!",
        isSuccess: true,
      );

      LoginNavigator.goToMainApp(context);
    } else {
      _isLoading = false;
      // _errorMessage = "Invalid email or pasadssword.";
      LoginNavigator.showToast(
        "Login failed. Check credentials.",
        isSuccess: false,
      );

      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
