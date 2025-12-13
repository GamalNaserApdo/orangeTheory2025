// lib/ui/add_package/add_package_navigator.dart

import 'package:flutter/material.dart';
import 'package:otfksa2/ui/add_packege/add_package_view.dart';
import 'package:otfksa2/ui/add_packege/add_package_viewmodel.dart';

class AddPackageNavigator {
  final BuildContext context;

  // Constructor to receive the context
  AddPackageNavigator(this.context);

  // Example navigation method: Pop back to the previous screen
  void pop() {
    Navigator.of(context).pop();
  }

  void navigateToAddPackage() {
    final viewModel = AddPackageViewModel(navigator: this);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AddPackageView(viewModel: viewModel)),
    );
  }

  // You can add other methods here, like showing a success dialog
  // void showSuccessMessage() { ... }
}
