import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:otfksa2/ui/login/login_navigator.dart';

class SignupViewModel extends ChangeNotifier {
  final supabase = Supabase.instance.client;

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // State Variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _obscureConfirmPassword = true;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Toggle Password Visibility
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  // Signup Function
  Future<void> onSignupPressed(BuildContext context) async {
    // Validation
    if (nameController.text.trim().isEmpty) {
      _errorMessage = "Please enter your full name";
      notifyListeners();
      return;
    }

    if (emailController.text.trim().isEmpty) {
      _errorMessage = "Please enter your email";
      notifyListeners();
      return;
    }

    if (passwordController.text.isEmpty) {
      _errorMessage = "Please enter a password";
      notifyListeners();
      return;
    }

    if (passwordController.text.length < 6) {
      _errorMessage = "Password must be at least 6 characters";
      notifyListeners();
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      _errorMessage = "Passwords do not match";
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Create user with Supabase Auth
      final AuthResponse res = await supabase.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text,
        data: {
          'full_name': nameController.text.trim(),
        },
      );

      final user = res.user;

      if (user != null) {
        // Insert user profile with admin role
        await supabase.from('profiles').insert({
          'id': user.id,
          'full_name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'role': 'user',
          'created_at': DateTime.now().toIso8601String(),
        });

        LoginNavigator.showToast(
          "Account created successfully! Please login.",
          isSuccess: true,
        );

        // Navigate back to login
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    } on AuthException catch (e) {
      _errorMessage = e.message;
      notifyListeners();
    } catch (e) {
      _errorMessage = "An unexpected error occurred. Please try again.";
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

