
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1/api";

  // تسجيل الدخول
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('\$baseUrl/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('فشل تسجيل الدخول: ${response.body}');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: \$e');
    }
  }

  // تسجيل مستخدم جديد
  static Future<Map<String, dynamic>> register(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('\$baseUrl/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('فشل تسجيل المستخدم: ${response.body}');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: \$e');
    }
  }
}
