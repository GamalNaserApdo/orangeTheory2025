// lib/ui/add_package/add_package_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:otfksa2/ui/add_packege/add_package_navigator.dart';

class AddPackageViewModel extends ChangeNotifier {
  // State variables for the input fields
  String _packageName = '';
  // ... other data fields ...

  // A link to the Navigator to handle screen changes
  final AddPackageNavigator navigator;
  // A link to your data service (e.g., API_Service)
  // final ApiService apiService;

  AddPackageViewModel({required this.navigator /*, required this.apiService*/});

  void setPackageName(String value) {
    _packageName = value;
    // notifyListeners(); // Only if the UI needs to update based on this change
  }

  // The main function to save the new package
  Future<void> savePackage() async {
    // 1. Create the new model object
    // final newPackage = PackageModel(name: _packageName, ...);

    // 2. Call a service to save it
    // final success = await apiService.createPackage(newPackage);

    // 3. Use the Navigator to go back or show a success message
    // if (success) {
    //   navigator.pop();
    // } else {
    //   // show error
    // }
  }
}
