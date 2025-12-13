// lib/ui/add_package/add_package_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:otfksa2/ui/add_packege/package_navigator.dart';
// import 'package:your_project_name/models/package_model.dart'; // Import if needed

class AddPackageViewModel extends ChangeNotifier {
  final AddPackageNavigator navigator;

  // State to hold the new package name input
  String _packageName = '';

  AddPackageViewModel({required this.navigator});

  // -----------------------------------------------------------------
  // THIS IS THE MISSING METHOD/SETTER!
  // It receives the text input from the View (TextField) and updates the state.
  void setPackageName(String value) {
    _packageName = value;
    // You might call notifyListeners() here if other parts of the view
    // depend on the input immediately, but usually not necessary for simple input.
  }
  // -----------------------------------------------------------------

  // Placeholder for the save function
  void savePackage() {
    // 1. Logic to validate inputs...
    if (_packageName.isEmpty) {
      // Show error
      return;
    }

    // 2. Logic to call API/Service to save the package using _packageName...
    // TODO: Implement API call

    // After saving, use the navigator to close the screen:
    navigator.pop();
  }
}
