// lib/ui/drawer/package_drawer/package_navigator.dart

import 'package:flutter/material.dart';
import 'package:otfksa2/ui/add_packege/add_package_view.dart';
import 'package:otfksa2/ui/add_packege/add_package_viewmodel.dart';
import 'package:otfksa2/ui/add_packege/package_navigator.dart';

class PackageNavigator {
  final BuildContext context;

  PackageNavigator(this.context);

  void navigateToAddPackage() {
    // 1. تهيئة الـ Navigator الجديد
    final addPackageNavigator = AddPackageNavigator(context);

    // 2. تهيئة الـ View Model الجديد
    final addPackageViewModel = AddPackageViewModel(
      navigator: addPackageNavigator,
    );

    // 3. الانتقال إلى الشاشة الجديدة
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddPackageView(viewModel: addPackageViewModel),
      ),
    );
  }
}
