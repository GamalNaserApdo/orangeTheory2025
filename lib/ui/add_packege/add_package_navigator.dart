// lib/ui/add_package/add_package_navigator.dart

import 'package:flutter/material.dart';

class AddPackageNavigator {
  final BuildContext context;

  AddPackageNavigator(this.context);

  void pop() {
    Navigator.of(context).pop();
  }

  void showSuccessDialog() {
    // Use the context to show a success message dialog
  }
}