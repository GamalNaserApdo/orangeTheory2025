import 'package:flutter/material.dart';
// import 'package:otfksa2/models/subscription_plan_model.dart'; // تأكد من المسار
// import 'edit_plan_navigator.dart'; // إذا كنت ستضيف تنقلات من هذه الشاشة

class EditPlanViewModel extends ChangeNotifier {
  static const Color primaryColor = Color(0xFFF37B2D);

  final String planId; // الـ ID اللي استقبلناه
  
  // Controllers لحقول الإدخال
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController subscribersController;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  bool _isSaving = false;
  bool get isSaving => _isSaving;

  EditPlanViewModel({required this.planId}) {
    // 1. تهيئة الـ Controllers
    nameController = TextEditingController();
    priceController = TextEditingController();
    subscribersController = TextEditingController();
    
    // 2. بدء عملية جلب البيانات
    _fetchPlanDetails();
  }
  
  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    subscribersController.dispose();
    super.dispose();
  }

  Future<void> _fetchPlanDetails() async {
    _isLoading = true;
    notifyListeners();

    // --- محاكاة جلب بيانات الخطة من Repository/API ---
    await Future.delayed(const Duration(seconds: 1));
    
    // نفترض أننا جلبنا بيانات الخطة "Premium"
    nameController.text = "Premium";
    priceController.text = "49";
    subscribersController.text = "567";

    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveChanges(BuildContext context) async {
    _isSaving = true;
    notifyListeners();
    
    // --- محاكاة حفظ البيانات ---
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // هنا يتم إرسال البيانات المحدثة (التي في الـ Controllers) للـ API
    print('Saving changes for Plan ID: $planId');
    print('New Name: ${nameController.text}');
    
    _isSaving = false;
    notifyListeners();
    
    // بعد الحفظ بنجاح، نرجع للشاشة اللي قبلها
    Navigator.pop(context); 
  }
}