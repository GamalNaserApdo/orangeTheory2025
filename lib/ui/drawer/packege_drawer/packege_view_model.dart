import 'package:flutter/material.dart';
import 'package:otfksa2/models/packege_model.dart';

class PackagesViewModel extends ChangeNotifier {
  static const Color primaryColor = Color(0xFFF37B2D);

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Package> _packages = [];
  List<Package> get packages => _packages;

  PackagesViewModel() {
    _fetchPackages();
  }

  Future<void> _fetchPackages() async {
    _isLoading = true;
    notifyListeners();

    // محاكاة جلب البيانات
    await Future.delayed(const Duration(milliseconds: 700));

    _packages = [
      Package(id: 'p1', name: 'Starter Pack', price: '\$50', classesCount: 5),
      Package(
        id: 'p2',
        name: 'Elite 10 Classes',
        price: '\$90',
        classesCount: 10,
        isFeatured: true,
      ),
      Package(
        id: 'p3',
        name: 'Unlimited Monthly',
        price: '\$150',
        classesCount: 999,
      ),
      Package(id: 'p4', name: 'Weekend Pass', price: '\$30', classesCount: 3),
    ];

    _isLoading = false;
    notifyListeners();
  }

  void onAddPackage(BuildContext context) {
    // TODO: Navigate to Add Package screen
    // Navigator.pushNamed(context, '/add-package');
  }

  void onEditPackage(BuildContext context, String packageId) {
    // TODO: Navigate to Edit Package screen
    // Navigator.pushNamed(context, '/edit-package', arguments: packageId);
  }
}
