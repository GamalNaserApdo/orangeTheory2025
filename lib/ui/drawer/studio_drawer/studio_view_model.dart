import 'package:flutter/material.dart';
import 'package:otfksa2/models/studio_model.dart';

class StudiosViewModel extends ChangeNotifier {
  static const Color primaryColor = Color(0xFFF37B2D);

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Studio> _studios = [];
  List<Studio> get studios => _studios;

  StudiosViewModel() {
    _fetchStudios();
  }

  Future<void> _fetchStudios() async {
    _isLoading = true;
    notifyListeners();

    // محاكاة جلب البيانات
    await Future.delayed(const Duration(milliseconds: 700));

    _studios = [
      Studio(id: 's1', name: 'Riyadh - Olaya', location: 'Olaya Tower, Riyadh', contactPhone: '+966 50 123 4567', isActive: true),
      Studio(id: 's2', name: 'Jeddah - Al Hamra', location: 'King Abdullah Rd, Jeddah', contactPhone: '+966 50 765 4321', isActive: true),
      Studio(id: 's3', name: 'Dammam - Corniche', location: 'Corniche Area, Dammam', contactPhone: '+966 50 987 6543', isActive: false),
    ];

    _isLoading = false;
    notifyListeners();
  }

  void onAddStudio(BuildContext context) {
    // StudiosNavigator.goToAddStudio(context);
    print('ViewModel: Navigating to Add New Studio');
  }
}
