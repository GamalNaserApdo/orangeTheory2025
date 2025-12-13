import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:otfksa2/ui/login/login_navigator.dart';

class LoginViewModel extends ChangeNotifier {
  // 1. تعريف Supabase Client
  final supabase = Supabase.instance.client;

  static const Color primaryColor = Color(0xFFF37B2D);

  // Controllers
  final TextEditingController emailController = TextEditingController(
    text: "admin@gmail.com", // يفضل تركه فارغاً أو وضع قيمة للتجربة
  );
  final TextEditingController passwordController = TextEditingController(
    text: "admin",
  );

  // State Variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Toggle Password View
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  // ⭐️ دالة تسجيل الدخول (تم دمج منطق Supabase هنا)
  Future<void> onLoginPressed(BuildContext context) async {
    // 1. التحقق من المدخلات قبل الإرسال
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      LoginNavigator.showToast(
        "Please enter both email and password.",
        isSuccess: false,
      );
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // 2. محاولة تسجيل الدخول عبر Supabase Auth
      // نستخدم trim() لإزالة أي مسافات زائدة
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final user = res.user;

      if (user != null) {
        // 3. التحقق مما إذا كان المستخدم مسجلاً كـ Admin في جدول profiles
        // (يفترض أنك أنشأت الجدول كما شرحنا سابقاً)
        final data = await supabase
            .from('profiles')
            .select('role')
            .eq('id', user.id)
            .single();

        // جلب الدور (Role)
        String role = data['role'] ?? 'user';

        if (role == 'admin') {
          // ✅ نجاح: المستخدم أدمن
          LoginNavigator.showToast(
            "Login successful. Welcome Admin!",
            isSuccess: true,
          );

          // الانتقال للشاشة الرئيسية
          LoginNavigator.goToMainApp(context);
        } else {
          // ❌ فشل: المستخدم ليس أدمن (مستخدم عادي)
          await supabase.auth.signOut(); // طرده فوراً

          LoginNavigator.showToast(
            "Access Denied: You do not have admin privileges.",
            isSuccess: false,
          );
        }
      }
    } on AuthException catch (e) {
      // خطأ من Supabase (مثلاً: إيميل غلط، باسورد غلط)
      LoginNavigator.showToast(
        e.message, // رسالة الخطأ القادمة من السيرفر
        isSuccess: false,
      );
    } catch (e) {
      // أي خطأ آخر غير متوقع
      LoginNavigator.showToast(
        "An unexpected error occurred. Please try again.",
        isSuccess: false,
      );
      print("Login Error: $e");
    } finally {
      // في النهاية، نوقف التحميل سواء نجح أو فشل
      _isLoading = false;
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
